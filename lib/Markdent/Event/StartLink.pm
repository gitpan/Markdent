package Markdent::Event::StartLink;
$Markdent::Event::StartLink::VERSION = '0.25';
use strict;
use warnings;
use namespace::autoclean;

use Markdent::Types qw( Str Bool );

use Moose;
use MooseX::StrictConstructor;

has uri => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has title => (
    is        => 'ro',
    isa       => Str,
    predicate => 'has_title',
);

has id => (
    is        => 'ro',
    isa       => Str,
    predicate => 'has_id',
);

has is_implicit_id => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
);

with 'Markdent::Role::Event';

with 'Markdent::Role::BalancedEvent';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: An event for the start of a link

__END__

=pod

=head1 NAME

Markdent::Event::StartLink - An event for the start of a link

=head1 VERSION

version 0.25

=head1 DESCRIPTION

This class represents the start of a link.

=head1 ATTRIBUTES

This class has the following attributes:

=head2 uri

The uri for the link.

=head2 title

The link title. This is optional.

=head2 id

The link's id. This is optional.

=head2 is_implicit_id

This will be true if the link's id was not specified explicitly in the
Markdown text.

=head1 ROLES

This class does the L<Markdent::Role::Event> and
L<Markdent::Role::BalancedEvent> roles.

=head1 BUGS

See L<Markdent> for bug reporting details.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
