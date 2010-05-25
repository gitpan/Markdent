package Markdent::Handler::Multiplexer;
BEGIN {
  $Markdent::Handler::Multiplexer::VERSION = '0.12';
}

use strict;
use warnings;

use Markdent::Types qw( NonEmptyArrayRef HandlerObject );

use namespace::autoclean;
use Moose;
use MooseX::StrictConstructor;

with 'Markdent::Role::Handler';

has _handlers => (
    is       => 'ro',
    isa      => NonEmptyArrayRef[HandlerObject],
    init_arg => 'handlers',
    required => 1,
);

sub handle_event {
    $_->handle_event( $_[1] ) for @{ $_[0]->_handlers() };
}

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: Passes events on to multiple handlers



=pod

=head1 NAME

Markdent::Handler::Multiplexer - Passes events on to multiple handlers

=head1 VERSION

version 0.12

=head1 DESCRIPTION

This class passes the event stream onto one or more handlers. This is handy if
you want to do multiple things with a document at once, for example generate
HTML and capture the events to save for a cache.

=head1 METHODS

This class provides the following methods:

=head2 Markdent::Handler::Multiplexer->new( handlers => [ ... ] )

This method creates a new handler. You must pass a list of one or more objects
which do the L<Markdent::Role::Handler> role as the "handlers" parameters.

=head1 ROLES

This class does the L<Markdent::Role::Handler> role.

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

