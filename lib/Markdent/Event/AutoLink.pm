package Markdent::Event::AutoLink;
BEGIN {
  $Markdent::Event::AutoLink::VERSION = '0.12';
}

use strict;
use warnings;

use Markdent::Types qw( Str Bool );

use namespace::autoclean;
use Moose;
use MooseX::StrictConstructor;

has uri => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for auto-links



=pod

=head1 NAME

Markdent::Event::AutoLink - An event for auto-links

=head1 VERSION

version 0.12

=head1 DESCRIPTION

This class represents an auto-link, like C<< <http://example.com> >>.

=head1 ATTRIBUTES

This class has the following attributes:

=head2 uri

The uri in the auto-link.

=head1 ROLES

This class does the L<Markdent::Role::Event> role.

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

