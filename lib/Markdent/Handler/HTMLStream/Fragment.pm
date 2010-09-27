package Markdent::Handler::HTMLStream::Fragment;
BEGIN {
  $Markdent::Handler::HTMLStream::Fragment::VERSION = '0.17';
}

use strict;
use warnings;

use namespace::autoclean;
use Moose;
use MooseX::SemiAffordanceAccessor;

with 'Markdent::Role::HTMLStream';

sub start_document { }
sub end_document   { }

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: Turns Markdent events into an HTML fragment



=pod

=head1 NAME

Markdent::Handler::HTMLStream::Fragment - Turns Markdent events into an HTML fragment

=head1 VERSION

version 0.17

=head1 DESCRIPTION

This class takes an event stream and turns it into an HTML document, without a
doctype, C<< <html> >>, C<< <head> >> or C<< <body> >> tags.

=head1 METHODS

This role provides the following methods:

=head2 Markdent::Handler::HTMLStream::Document->new(...)

This method creates a new handler. It accepts the following parameters:

=over 4

=item * output => $fh

The file handle to which HTML output will be streamed. If you want to capture
the output in a string, you can open a filehandle to a string:

  my $buffer = q{};
  open my $fh, '>', \$buffer;

=back

=head1 ROLES

This class does the L<Markdent::Role::HTMLStream>,
L<Markdent::Role::EventsAsMethods>, and L<Markdent::Role::Handler> roles.

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

