package Markdent::Types::Internal;
BEGIN {
  $Markdent::Types::Internal::VERSION = '0.11';
}

use strict;
use warnings;

use IO::Handle;

use MooseX::Types -declare => [
    qw( HeaderLevel
        BlockParserClass
        SpanParserClass
        EventObject
        HandlerObject
        OutputStream
        NonEmptyArrayRef
        TableCellAlignment
        PosInt
        )
];

use MooseX::Types::Moose qw( Int ArrayRef ClassName Any FileHandle Object );

subtype HeaderLevel,
    as Int,
    where { $_ >= 1 && $_ <= 6 },
    message { "Header level must be a number from 1-6 (not $_)" };

subtype BlockParserClass,
    as ClassName,
    where { $_->can('does') && $_->does('Markdent::Role::BlockParser') };

subtype SpanParserClass,
    as ClassName,
    where { $_->can('does') && $_->does('Markdent::Role::SpanParser') };

subtype EventObject,
    as Object,
    where { $_->can('does') && $_->does('Markdent::Role::Event') };

subtype HandlerObject,
    as Object,
    where { $_->can('does') && $_->does('Markdent::Role::Handler') };

subtype NonEmptyArrayRef,
    as ArrayRef,
    where { @{$_} >= 1 };

subtype OutputStream,
    as Any,
    where {
        FileHandle->check($_)
            || ( Object->check($_) && $_->can('print') );
    },
    message { 'The output stream must be a Perl file handle or an object with a print method' };

enum TableCellAlignment, qw( left right center );

subtype PosInt,
    as Int,
    where { $_ >= 1 },
    message {"The number provided ($_) is not a positive integer"};

1;

__END__
=pod

=head1 NAME

Markdent::Types::Internal

=head1 VERSION

version 0.11

=head1 AUTHOR

  Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

