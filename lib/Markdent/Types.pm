package Markdent::Types;
BEGIN {
  $Markdent::Types::VERSION = '0.11';
}

use strict;
use warnings;

use base 'MooseX::Types::Combine';

__PACKAGE__->provide_types_from(
    qw( Markdent::Types::Internal
        MooseX::Types::Moose ));

1;

__END__
=pod

=head1 NAME

Markdent::Types

=head1 VERSION

version 0.11

=head1 AUTHOR

  Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

