package Markdent::Role::Dialect::BlockParser;
{
  $Markdent::Role::Dialect::BlockParser::VERSION = '0.23';
}
BEGIN {
  $Markdent::Role::Dialect::BlockParser::AUTHORITY = 'cpan:DROLSKY';
}

use strict;
use warnings;

use Moose::Role;

1;

# ABSTRACT: A role for a dialect block parser

__END__

=pod

=head1 NAME

Markdent::Role::Dialect::BlockParser - A role for a dialect block parser

=head1 VERSION

version 0.23

=head1 DESCRIPTION

This role has no internals, it simply indicates that the role which consumes
it is a block parser role.

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
