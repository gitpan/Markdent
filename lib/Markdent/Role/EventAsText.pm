package Markdent::Role::EventAsText;
BEGIN {
  $Markdent::Role::EventAsText::VERSION = '0.12';
}

use strict;
use warnings;

use namespace::autoclean;
use Moose::Role;

requires 'as_text';

1;

# ABSTRACT: Indicates that an event has an as_text method



=pod

=head1 NAME

Markdent::Role::EventAsText - Indicates that an event has an as_text method

=head1 VERSION

version 0.12

=head1 DESCRIPTION

An event with an as_text method will do this role.

=head1 REQUIRED METHODS

=over 4

=item * $handler->as_text()

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

