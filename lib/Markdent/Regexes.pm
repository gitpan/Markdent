package Markdent::Regexes;
BEGIN {
  $Markdent::Regexes::VERSION = '0.13';
}

use strict;
use warnings;

use List::AllUtils qw( uniq );

use base 'Exporter';

our %EXPORT_TAGS = (
    block => [
        qw( $HorizontalWS
            $EmptyLine
            $EmptyLines
            $BlockStart
            $BlockEnd
            ),
    ],
    span  => [],
    other => [qw( $HTMLComment )],
);

our @EXPORT_OK = uniq( map { @{$_} } values %EXPORT_TAGS );

our $HorizontalWS = qr/(?: \p{SpaceSeparator} | \t )/x;
our $EmptyLine = qr/(?: ^ $HorizontalWS* \n ) /xm;
our $EmptyLines = qr/ (?: $EmptyLine )+ /xm;

our $BlockStart = qr/(?: \A | $EmptyLines )/xm;
our $BlockEnd = qr/(?=(?: $EmptyLines | \z ) )/xm;

our $HTMLComment = qr{<!--(.+?)-->}s;

1;

__END__
=pod

=head1 NAME

Markdent::Regexes

=head1 VERSION

version 0.13

=head1 AUTHOR

  Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

