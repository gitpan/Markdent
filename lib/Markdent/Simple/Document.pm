package Markdent::Simple::Document;
{
  $Markdent::Simple::Document::VERSION = '0.19';
}

use strict;
use warnings;
use namespace::autoclean;

use Markdent::Handler::HTMLStream::Document;
use Markdent::Parser;
use Markdent::Types qw( Str );
use MooseX::Params::Validate qw( validated_list );

use Moose;
use MooseX::StrictConstructor;

sub markdown_to_html {
    my $self = shift;
    my ( $dialect, $title, $markdown ) = validated_list(
        \@_,
        dialect  => { isa => Str, default => 'Standard' },
        title    => { isa => Str },
        markdown => { isa => Str },
    );

    my $capture = q{};
    open my $fh, '>', \$capture
        or die $!;

    my $handler = Markdent::Handler::HTMLStream::Document->new(
        title  => $title,
        output => $fh,
    );

    my $parser
        = Markdent::Parser->new( dialect => $dialect, handler => $handler );

    $parser->parse( markdown => $markdown );

    return $capture;
}

1;

# ABSTRACT: Convert Markdown to an HTML Document



=pod

=head1 NAME

Markdent::Simple::Document - Convert Markdown to an HTML Document

=head1 VERSION

version 0.19

=head1 SYNOPSIS

    use Markdent::Simple::Document;

    my $mds  = Markdent::Simple::Document->new();
    my $html = $mss->markdown_to_html(
        title    => 'My Document',
        markdown => $markdown,
    );

=head1 DESCRIPTION

This class provides a very simple interface for converting Markdown to a
complete HTML document.

=head1 METHODS

This class provides the following methods:

=head2 Markdent::Simple::Document->new()

Creates a new Markdent::Simple::Document object.

=head2 $mds->markdown_to_html( title => $title, markdown => $markdown )

This method turns Markdown into HTML. You must provide a title as well, which
will be used as the C<< <title> >> for the resulting HTML document.

You can also provide an optional "dialect" parameter.

=head1 BUGS

See L<Markdent> for bug reporting details.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

