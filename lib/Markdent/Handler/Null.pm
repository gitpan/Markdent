package Markdent::Handler::Null;
{
  $Markdent::Handler::Null::VERSION = '0.23';
}
BEGIN {
  $Markdent::Handler::Null::AUTHORITY = 'cpan:DROLSKY';
}

use strict;
use warnings;
use namespace::autoclean;

use Moose;
use MooseX::StrictConstructor;

with 'Markdent::Role::Handler';

sub handle_event {
    return;
}

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: A handler which ignores all events

__END__

=pod

=head1 NAME

Markdent::Handler::Null - A handler which ignores all events

=head1 VERSION

version 0.23

=head1 DESCRIPTION

This class implements an event receiver which ignores all events.

=head1 METHODS

This class provides the following methods:

=head2 Markdent::Handler::Null->new()

This method creates a new handler.

=head1 ROLES

This class does the L<Markdent::Role::Handler> role.

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
