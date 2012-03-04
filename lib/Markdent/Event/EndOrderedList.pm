package Markdent::Event::EndOrderedList;
{
  $Markdent::Event::EndOrderedList::VERSION = '0.18';
}

use strict;
use warnings;
use namespace::autoclean;

use Moose;
use MooseX::StrictConstructor;

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for the end of a ordered list



=pod

=head1 NAME

Markdent::Event::EndOrderedList - An event for the end of a ordered list

=head1 VERSION

version 0.18

=head1 DESCRIPTION

This class represents the end of a ordered list.

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

