package Markdent::Event::HTMLEntity;
{
  $Markdent::Event::HTMLEntity::VERSION = '0.20';
}

use strict;
use warnings;
use namespace::autoclean;

use Markdent::Types qw( Str );

use Moose;
use MooseX::StrictConstructor;

has entity => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for an HTML entity



=pod

=head1 NAME

Markdent::Event::HTMLEntity - An event for an HTML entity

=head1 VERSION

version 0.20

=head1 DESCRIPTION

This class represents an HTML entity, like "amp" or "#0xc3".

=head1 ATTRIBUTES

This class has the following attributes:

=head2 entity

The text of the entity. This omits the leading ampersand and ending
semi-colon.

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

