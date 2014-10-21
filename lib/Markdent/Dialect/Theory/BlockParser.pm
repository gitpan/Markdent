package Markdent::Dialect::Theory::BlockParser;

use strict;
use warnings;

our $VERSION = '0.06';

use List::AllUtils qw( insert_after_string sum );
use Markdent::Event::StartTable;
use Markdent::Event::EndTable;
use Markdent::Event::StartTableHeader;
use Markdent::Event::EndTableHeader;
use Markdent::Event::StartTableBody;
use Markdent::Event::EndTableBody;
use Markdent::Event::StartTableRow;
use Markdent::Event::EndTableRow;
use Markdent::Event::StartTableCell;
use Markdent::Event::EndTableCell;
use Markdent::Regexes qw( $HorizontalWS $EmptyLine $BlockStart $BlockEnd );
use Markdent::Types qw( Bool );

use namespace::autoclean;
use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

extends 'Markdent::Dialect::Standard::BlockParser';

has _in_table => (
    traits   => ['Bool'],
    isa      => Bool,
    default  => 0,
    init_arg => undef,
    handles  => {
        _enter_table => 'set',
        _leave_table => 'unset',
    },
);

sub _possible_block_matches {
    my $self = shift;

    my @look_for = $self->SUPER::_possible_block_matches();

    return @look_for if $self->_list_level();

    if ( $self->_in_table() ) {
        insert_after_string 'list', 'table_cell', @look_for;
    }
    else {
        insert_after_string 'list', 'table', @look_for;
    }

    return @look_for;
}

my $TableCaption = qr{ ^
                       $HorizontalWS*
                       \[
                       (.*)
                       \]
                       $HorizontalWS*
                       \n
                     }xm;

my $TableRow = qr{ ^
                   [|]?            # a regular pipe-separated row
                   (?:
                     .*?
                     (?<!\\)
                     [|]
                   )+
                   .*?
                   \n
                   (?:
                     ^
                     :?           # a colon-separated row continuation line
                     (?:
                       .*?
                       (?<!\\)
                       :
                     )+
                     .*?
                     \n
                   )*             # ... can have 0+ continuation lines
                 }xm;

my $HeaderSecondLine = qr/^[\-\+=]+\n/xm;

my $TableHeader = qr{ $TableRow
                      $HeaderSecondLine
                    }xm;

sub _match_table {
    my $self = shift;
    my $text = shift;

    return unless ${$text} =~ / \G
                                $BlockStart
                                (
                                  $TableCaption?
                                  ($TableHeader+)?
                                  (
                                    (?:
                                      $TableRow
                                      |
                                      $EmptyLine
                                    )+
                                  )
                                  $TableCaption?
                                )
                                $BlockEnd
                              /xmgc;

    $self->_debug_parse_result(
        $1,
        'table',
    ) if $self->debug();

    my $caption = defined $2 ? $2 : $5;

    $self->_debug_parse_result(
        $caption,
        'table caption',
    ) if defined $caption && $self->debug();

    my $header = $3;
    my $body = $4;

    $self->_debug_parse_result(
        $header,
        'table header',
    ) if $self->debug();

    $self->_debug_parse_result(
        $body,
        'table body',
    ) if $self->debug();

    my @header;

    if ( defined $header ) {
        @header = $self->_parse_rows( qr/$HeaderSecondLine/m, $header );
        $_->{is_header_cell} = 1 for map { @{$_} } @header;
    }

    my @body = $self->_parse_rows( qr/\n/, $body );

    $self->_normalize_cell_count_and_alignments( @header, @body );

    if (@header) {
        my $first_header_cell_content = $header[0][0]{content};
        unless ( defined $first_header_cell_content
                 && $first_header_cell_content =~ /\S/ ) {
            $_->[0]{is_header_cell} = 1 for @body;
        }
    }

    $self->_enter_table();

    my %caption = defined $caption ? ( caption => $caption ) : ();
    $self->_send_event( 'StartTable', %caption );

    $self->_events_for_rows( \@header, 'Header' )
        if @header;
    $self->_events_for_rows( \@body,   'Body' );

    $self->_send_event('EndTable');

    $self->_leave_table();

    return 1;
}

sub _parse_rows {
    my $self = shift;
    my $split_re = shift;
    my $rows = shift;

    my @rows;

    for my $chunk ( split $split_re, $rows ) {
        # Splitting on an empty string returns nothing, so we need to
        # special-case that, as we want to preserve empty lines.
        for my $line ( length $chunk ? ( split /\n/, $chunk ) : $chunk ) {
            if ( $line =~ /^$HorizontalWS*$/ ) {
                push @rows, undef;
            }
            elsif ( $self->_is_continuation_line($line) ) {

                # If the $TableRow regex is correct, this shouldn't be
                # possible.
                die "Continuation of a row before we've seen a row start?!"
                    unless @rows;

                my $cells = $self->_cells_from_line( $line, ':' );

                for my $i ( 0 .. $#{$cells} ) {
                    if ( defined $cells->[$i]{content}
                        && $cells->[$i]{content} =~ /\S/ ) {
                        $rows[-1][$i]{content} .= "\n" . $cells->[$i]{content};
                    }
                }
            }
            else {
                push @rows, $self->_cells_from_line( $line, '|' );
            }
        }
    }

    return @rows;
}

sub _is_continuation_line {
    my $self = shift;
    my $line = shift;

    return 0
        if $line =~ /(?<!\\)[|]/x;

    return 1
        if $line =~ /(?<!\\):/x;

    # a blank line, presumably
    return 0;
}

sub _cells_from_line {
    my $self = shift;
    my $line = shift;
    my $div  = shift;

    my @row;

    for my $cell ( $self->_split_cells($line, $div) ) {
        if ( length $cell ) {
            push @row, $self->_cell_params($cell);
        }
        # If the first cell is empty, we just treat it as an empty cell.
        elsif (@row) {
            $row[-1]{colspan}++;
        }
    }

    return \@row;
}

sub _split_cells {
    my $self = shift;
    my $line = shift;
    my $div  = shift;

    $line =~ s/^\Q$div//;
    $line =~ s/\Q$div\E\p{SpaceSeparator}*$/$div/;

    # We don't want to split on a backslash-escaped divider, thus the
    # lookbehind. The -1 ensures that Perl gives us the trailing empty fields.
    my @cells = split /(?<!\\)\Q$div/, $line, -1;

    # If the line has just one divider as the line-ending, it should not be
    # treated as marking an empty cell.
    if ( $cells[-1] eq q{} && $line =~ /\Q$div\E$HorizontalWS*$/ ) {
        pop @cells;
    }

    return @cells;
}

sub _cell_params {
    my $self = shift;
    my $cell = shift;

    my $alignment;
    my $content;

    if ( defined $cell && $cell =~ /\S/ ) {
        $alignment = $self->_alignment_for_cell($cell);

        ( $content = $cell )
            =~ s/^\p{SpaceSeparator}+|\p{SpaceSeparator}+$//g;
    }

    my %p = (
        colspan => 1,
        content => $content,
    );

    $p{alignment} = $alignment
        if defined $alignment;

    return \%p;
}

sub _alignment_for_cell {
    my $self = shift;
    my $cell = shift;

    return 'center'
        if $cell =~ /^\p{SpaceSeparator}{2,}.+?\p{SpaceSeparator}{2,}$/;

    return 'left'
        if $cell =~ /\p{SpaceSeparator}{2,}$/;

    return 'right'
        if $cell =~ /^\p{SpaceSeparator}{2,}/;

    return undef;
}

sub _normalize_cell_count_and_alignments {
    my $self = shift;
    my @rows = @_;

    # We use the first header row as an indicator for how many cells we expect
    # on each line.
    my $default_cells = sum( map { $_->{colspan} } @{ $rows[0] } );

    # Alignments are inherited from the cell above, or they default to
    # "left". We loop through all the rules and set alignments accordingly.
    my %alignments;

    for my $row ( grep { defined } @rows ) {
        # If we have one extra column and the final cell has a colspan > 1 it
        # means we misinterpreted a trailing divider as indicating that the
        # prior cell had a colspan > 1. We adjust for that by comparing it to
        # the number of columns in the first row.
        if ( sum( map { $_->{colspan} } @{$row} ) == $default_cells + 1
             && $row->[-1]{colspan} > 1 ) {
            $row->[-1]{colspan}--;
        }

        my $i = 0;
        for my $cell ( @{$row} ) {
            if ( $cell->{alignment} ) {
                $alignments{$i} = $cell->{alignment};
            }
            else {
                $cell->{alignment} = $alignments{$i} || 'left';
            }

            $i += $cell->{colspan};
        }
    }
}

sub _events_for_rows {
    my $self = shift;
    my $rows = shift;
    my $type = shift;

    my $start = 'StartTable' . $type;
    my $end = 'EndTable' . $type;

    $self->_send_event($start);

    for my $row ( @{$rows} ) {
        if ( ! defined $row ) {
            $self->_send_event($end);
            $self->_send_event($start);
            next;
        }

        $self->_send_event('StartTableRow');

        for my $cell ( @{$row} ) {
            my $content = delete $cell->{content};

            $self->_send_event(
                'StartTableCell',
                %{$cell}
            );

            if ( defined $content ) {
                # If the content has newlines, it should be matched as a
                # block-level construct (blockquote, list, etc), but to make
                # that work, it has to have a trailing newline.
                $content .= "\n"
                    if $content =~ /\n/;

                $self->_parse_text(\$content);
            }

            $self->_send_event(
                'EndTableCell',
                is_header_cell => $cell->{is_header_cell},
            );
        }

        $self->_send_event('EndTableRow');
    }

    $self->_send_event($end);
}

# A table cell's contents can be a single line _not_ terminated by a
# newline. If that's the case, it won't match as a paragraph.
sub _match_table_cell {
    my $self = shift;
    my $text = shift;

    return unless ${$text} =~ / \G
                                (
                                  ^
                                  \p{SpaceSeparator}*
                                  \S
                                  .*
                                )
                                \z
                              /xmgc;

    $self->_debug_parse_result(
        $1,
        'table cell',
    ) if $self->debug();

    $self->_span_parser()->parse_block($1);
}

__PACKAGE__->meta()->make_immutable();

1;

__END__

=pod

=head1 NAME

Markdent::Dialect::Standard::BlockParser - Block parser for Theory's Markdown

=head1 DESCRIPTION

This class adds parsing for Markdown extensions proposed by David Wheeler (aka
Theory). See
L<http://justatheory.com/computers/markup/markdown-table-rfc.html> and
L<http://justatheory.com/computers/markup/modest-markdown-proposal.html> for
details.

For now, this class handles tables only.

This class extends the L<Markdent::Dialect::Standard::BlockParser> class.

=head1 METHODS

This class provides the following methods:

=head1 ROLES

This class does the L<Markdent::Role::BlockParser>,
L<Markdent::Role::AnyParser>, and L<Markdent::Role::DebugPrinter> roles.

=head1 BUGS

See L<Markdent> for bug reporting details.

=head1 AUTHOR

Dave Rolsky, E<lt>autarch@urth.orgE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
