package Markdent::Dialect::Theory::SpanParser;
BEGIN {
  $Markdent::Dialect::Theory::SpanParser::VERSION = '0.11';
}

use strict;
use warnings;

use namespace::autoclean;
use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

extends 'Markdent::Dialect::Standard::SpanParser';


override _build_escapable_chars => sub {
    my $chars = super();

    return [ @{ $chars }, qw( | : ) ];
};

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: Span parser for Theory's Markdown



=pod

=head1 NAME

Markdent::Dialect::Theory::SpanParser - Span parser for Theory's Markdown

=head1 VERSION

version 0.11

=head1 DESCRIPTION

This class extends the L<Markdent::Dialect::Standard::SpanParser> class in
order to allow the pipe (|) and colon (:) characters to be
backslash-escaped. These are used to mark tables, so they need to be
escapeable.

=head1 METHODS

This class provides the following methods:

=head1 ROLES

This class does the L<Markdent::Role::SpanParser>,
L<Markdent::Role::AnyParser>, and L<Markdent::Role::DebugPrinter> roles.

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

