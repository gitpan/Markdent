package Markdent::Event::StartTableBody;
$Markdent::Event::StartTableBody::VERSION = '0.25';
use strict;
use warnings;
use namespace::autoclean;

use Markdent::Types qw( Str );

use Moose;
use MooseX::StrictConstructor;

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for the start of a table body

__END__

=pod

=head1 NAME

Markdent::Event::StartTableBody - An event for the start of a table body

=head1 VERSION

version 0.25

=head1 DESCRIPTION

This class represents the start of a table body. A table can have more than
one body.

=head1 ROLES

This class does the L<Markdent::Role::Event> role.

=head1 BUGS

See L<Markdent> for bug reporting details.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
