package Markdent::Role::FilterHandler;
{
  $Markdent::Role::FilterHandler::VERSION = '0.23';
}
BEGIN {
  $Markdent::Role::FilterHandler::AUTHORITY = 'cpan:DROLSKY';
}

use strict;
use warnings;
use namespace::autoclean;

use Moose::Role;

with 'Markdent::Role::Handler';

requires 'filter_event';

has handler => (
    is       => 'ro',
    does     => 'Markdent::Role::Handler',
    required => 1,
);

sub handle_event {
    my $self  = shift;
    my $event = shift;

    my $new_event = $self->filter_event($event);

    $self->handler()->handle_event($new_event)
        if $new_event;
}

1;

# ABSTRACT: A role for handlers which act as filters

__END__

=pod

=head1 NAME

Markdent::Role::FilterHandler - A role for handlers which act as filters

=head1 VERSION

version 0.23

=head1 DESCRIPTION

This role implements behavior and interface for filtering handlers. A filter
handler takes events and does something to some of them, and then passes them
on to another handler.

=head1 REQUIRED METHODS

=over 4

=item * $handler->filter_event($event)

This method will always be called with a single object which does the
L<Markdent::Role::Event> role.

If this method returns a single event, it will be passed on to the next
handler. If it does not return an event, the event is dropped from the stream.

=back

=head1 ATTRIBUTES

This role provides the following attributes:

=head2 handler

This is a read-only attribute. It is an object which does the
L<Markdent::Role::Handler> role.

This is the handler to which the filter passes events after filtering.

=head1 BUGS

See L<Markdent> for bug reporting details.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 CONTRIBUTOR

Jason McIntosh <jmac@appleseed-sc.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
