package Markdent::Role::Dialect::SpanParser;
$Markdent::Role::Dialect::SpanParser::VERSION = '0.25';
use strict;
use warnings;

use Moose::Role;

1;

# ABSTRACT: A role for a dialect span parser

__END__

=pod

=head1 NAME

Markdent::Role::Dialect::SpanParser - A role for a dialect span parser

=head1 VERSION

version 0.25

=head1 DESCRIPTION

This role has no internals, it simply indicates that the role which consumes
it is a span parser role.

=head1 BUGS

See L<Markdent> for bug reporting details.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
