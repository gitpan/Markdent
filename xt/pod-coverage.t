#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage"
    if $@;

eval "use Pod::Coverage::Moose 0.02";
plan skip_all => "Pod::Coverage::Moose 0.02 required for testing POD coverage"
    if $@;

my %skip = map { $_ => 1 } qw( Markdent::Types Markdent::Types::Internal );

# This is a stripped down version of all_pod_coverage_ok which lets us
# vary the trustme parameter per module.
my @modules = grep { ! $skip{$_} } all_modules();
plan tests => scalar @modules;

my @handler_events = qw(
    auto_link
    end_blockquote
    end_code
    end_document
    end_emphasis
    end_header
    end_html_tag
    end_link
    end_list_item
    end_ordered_list
    end_paragraph
    end_strong
    end_unordered_list
    horizontal_rule
    html_tag
    html_block
    html_entity
    image
    preformatted
    start_blockquote
    start_code
    start_document
    start_emphasis
    start_header
    start_html_tag
    start_link
    start_list_item
    start_ordered_list
    start_paragraph
    start_strong
    start_unordered_list
    text
);

my %trustme = (
    'Markdent::Handler::HTMLStream'  => \@handler_events,
    'Markdent::Handler::MinimalTree' => \@handler_events,
    'Markdent::Parser'               => ['BUILD'],
);

for my $module ( sort @modules ) {
    my $trustme = [];

    if ( $trustme{$module} ) {
        my $methods = join '|', @{ $trustme{$module} };
        $trustme = [qr/^(?:$methods)$/];
    }

    pod_coverage_ok(
        $module, {
            coverage_class => 'Pod::Coverage::Moose',
            trustme        => $trustme,
        },
        "Pod coverage for $module"
    );
}
