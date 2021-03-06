package Markdent::Event::HTMLBlock;
$Markdent::Event::HTMLBlock::VERSION = '0.25';
use strict;
use warnings;
use namespace::autoclean;

use Markdent::Types qw( Str );

use Moose;
use MooseX::StrictConstructor;

has html => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for an HTML block

__END__

=pod

=head1 NAME

Markdent::Event::HTMLBlock - An event for an HTML block

=head1 VERSION

version 0.25

=head1 DESCRIPTION

This class represents a standalone block of HTML.

=head1 ATTRIBUTES

This class has the following attributes:

=head2 html

The HTML in the block. There is no guarantee that this HTML is actually valid.

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
