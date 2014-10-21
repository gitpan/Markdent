package Markdent::Event::StartListItem;
{
  $Markdent::Event::StartListItem::VERSION = '0.22';
}

use strict;
use warnings;
use namespace::autoclean;

use Markdent::Types qw( Str );

use Moose;
use MooseX::StrictConstructor;

has bullet => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for the start of a list item



=pod

=head1 NAME

Markdent::Event::StartListItem - An event for the start of a list item

=head1 VERSION

version 0.22

=head1 DESCRIPTION

This class represents the start of a list item.

=head1 ATTRIBUTES

This class has the following attributes:

=head2 bullet

The bullet text for the list item.

=head1 ROLES

This class does the L<Markdent::Role::Event> role.

=head1 BUGS

See L<Markdent> for bug reporting details.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

