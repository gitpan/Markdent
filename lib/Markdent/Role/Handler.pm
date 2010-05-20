package Markdent::Role::Handler;
BEGIN {
  $Markdent::Role::Handler::VERSION = '0.10';
}

use strict;
use warnings;

use namespace::autoclean;
use Moose::Role;

requires 'handle_event';

1;

# ABSTRACT: A required role for all handlers



=pod

=head1 NAME

Markdent::Role::Handler - A required role for all handlers

=head1 VERSION

version 0.10

=head1 DESCRIPTION

This role implements an interface shared by all handlers.

=head1 REQUIRED METHODS

=over 4

=item * $handler->handle_event($event)

This method will always be called with a single object which does the
L<Markdent::Role::Event> role.

=back

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

