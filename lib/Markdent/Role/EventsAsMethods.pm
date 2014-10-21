package Markdent::Role::EventsAsMethods;
{
  $Markdent::Role::EventsAsMethods::VERSION = '0.18';
}

use strict;
use warnings;
use namespace::autoclean;

use Scalar::Util qw( blessed );

use Moose::Role;

with 'Markdent::Role::Handler';

sub handle_event {
    my $self  = shift;
    my $event = shift;

    my $meth = $event->event_name();

    $self->$meth( $event->kv_pairs_for_attributes() );
}

1;

# ABSTRACT: Turns events into method calls



=pod

=head1 NAME

Markdent::Role::EventsAsMethods - Turns events into method calls

=head1 VERSION

version 0.18

=head1 DESCRIPTION

This role takes an object which does L<Markdent::Role::Event> role and turns
it into a method call.

=head1 METHODS

This role provides the following methods:

=head2 $object->handle_event($event)

Given an object which does L<Markdent::Role::Event> role, this method makes a
method call on C<$object> based on the event's name.

The method name is the same as the value of C<< $event->event_name() >>. The
hash reference returned by C<< $event->attributes() >> is turned into a set of
named parameters for the method. However, any keys starting with "!" in the
attributes will not be passed to the method.

So, for example, a L<Markdent::Event::StartLink> event turns into a method
call like this:

  $handler->start_link(
      uri            => $event->uri(),
      title          => $title,                     # optional
      id             => $id,                        # optional
      is_implicit_id => $event->is_implicit_id(),
  );

=head1 ROLES

This role does the L<Markdent::Role::Handler> role.

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

