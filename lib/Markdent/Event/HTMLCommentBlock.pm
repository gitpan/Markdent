package Markdent::Event::HTMLCommentBlock;
{
  $Markdent::Event::HTMLCommentBlock::VERSION = '0.19';
}

use strict;
use warnings;
use namespace::autoclean;

use Markdent::Types qw( Str HashRef );

use Moose;
use MooseX::StrictConstructor;

has text => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for an HTML comment as a standalone block



=pod

=head1 NAME

Markdent::Event::HTMLCommentBlock - An event for an HTML comment as a standalone block

=head1 VERSION

version 0.19

=head1 DESCRIPTION

This class represents the an HTML comment as a standalone block.

=head1 ATTRIBUTES

This class has the following attributes:

=head2 text

The text of the comment.

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

