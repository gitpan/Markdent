package Markdent::Event::StartHTMLTag;
{
  $Markdent::Event::StartHTMLTag::VERSION = '0.23';
}
BEGIN {
  $Markdent::Event::StartHTMLTag::AUTHORITY = 'cpan:DROLSKY';
}

use strict;
use warnings;
use namespace::autoclean;

use Markdent::Types qw( Str HashRef );

use Moose;
use MooseX::StrictConstructor;

has tag => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has attributes => (
    is      => 'ro',
    isa     => HashRef,
    default => sub { {} },
);

with 'Markdent::Role::Event';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for the start of an inline HTML tag

__END__

=pod

=head1 NAME

Markdent::Event::StartHTMLTag - An event for the start of an inline HTML tag

=head1 VERSION

version 0.23

=head1 DESCRIPTION

This class represents the start of an inline HTML tag.

=head1 ATTRIBUTES

This class has the following attributes:

=head2 tag

The tag that is starting.

=head2 attributes

A hash reference of attributes as key/value pairs. An attribute without a
value will have a value of C<undef> in the hash reference.

=head1 ROLES

This class does the L<Markdent::Role::Event> role.

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
