package Markdent::Event::CodeBlock;
$Markdent::Event::CodeBlock::VERSION = '0.25';
use strict;
use warnings;
use namespace::autoclean;

use Markdent::Types qw( Str );

use Moose;
use MooseX::StrictConstructor;

has code => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has language => (
    is        => 'ro',
    isa       => Str,
    predicate => 'has_language',
);

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for a code block

__END__

=pod

=head1 NAME

Markdent::Event::CodeBlock - An event for a code block

=head1 VERSION

version 0.25

=head1 DESCRIPTION

This class represents a block of code

=head1 ATTRIBUTES

This class has the following attributes:

=head2 code

The code in the block, including newlines and additional leading space, etc.

=head2 language

An optional language associated with the block, if one was specified. You can
use the C<has_language()> method to see if one is set.

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
