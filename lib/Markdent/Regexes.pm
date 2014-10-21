package Markdent::Regexes;

use strict;
use warnings;

our $VERSION = '0.05';

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
