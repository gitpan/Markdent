package Markdent::Event::EndHeader;

use strict;
use warnings;

use Markdent::Types qw( HeaderLevel );

use namespace::autoclean;
use Moose;
use MooseX::StrictConstructor;

has level => (
    is       => 'ro',
    isa      => HeaderLevel,
    required => 1,
);

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for the end of a header



=pod

=head1 NAME

Markdent::Event::EndHeader - An event for the end of a header

=head1 VERSION

version 0.15

=head1 DESCRIPTION

This class represents the end of a header.

=head1 ATTRIBUTES

This class has the following attributes:

=head2 level

A number from 1-6 indicating the header's level.

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

