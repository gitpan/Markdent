package Test::Markdent;

use strict;
use warnings;

use Data::Dumper;
use Test::Deep;
use Test::Differences;
use Test::More;
use Tree::Simple::Visitor::ToNestedArray;

eval { require HTML::Tidy };
my $HasTidy = $@ ? 0 : 1;

use Markdent::Handler::MinimalTree;
use Markdent::Parser;
use Markdent::Simple::Document;

use Exporter qw( import );

our @EXPORT = qw( tree_from_handler parse_ok html_output_ok );

sub parse_ok {
    my $parser_p    = ref $_[0] ? shift : {};
    my $markdown    = shift;
    my $expect_tree = shift;
    my $desc        = shift;

    my $handler_class = delete $parser_p->{handler_class}
        || 'Markdent::Handler::MinimalTree';
    my $handler = $handler_class->new();

    my $parser = Markdent::Parser->new( %{$parser_p}, handler => $handler );

    $parser->parse( markdown => $markdown );

    my $results = tree_from_handler($handler);

    diag( Dumper($results) )
        if $ENV{MARKDENT_TEST_VERBOSE};

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    cmp_deeply( $results, $expect_tree, $desc );
}

sub tree_from_handler {
    my $handler = shift;

    my $visitor = Tree::Simple::Visitor::ToNestedArray->new();
    $handler->tree()->accept($visitor);

    # The top level of this data structure is always a one element array ref
    # containing the document contents.
    return $visitor->getResults()->[0];
}

sub html_output_ok {
    my $dialect     = ref $_[0] ? shift : {};
    my $markdown    = shift;
    my $expect_html = shift;
    my $desc        = shift;

    unless ($HasTidy) {
    SKIP: { skip 'This test requires HTML::Tidy', 1; }

        return;
    }

    my $html = Markdent::Simple::Document->new()->markdown_to_html(
        %{$dialect},
        title    => 'Test',
        markdown => $markdown,
    );

    diag($html)
        if $ENV{MARKDENT_TEST_VERBOSE};

    my $tidy = HTML::Tidy->new(
        {
            doctype           => 'transitional',
            'sort-attributes' => 'alpha',
        }
    );

    my $real_expect_html = <<"EOF";
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <title>Test</title>
</head>
<body>
$expect_html
</body>
</html>
EOF

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    eq_or_diff( $tidy->clean($html), $tidy->clean($real_expect_html), $desc );
}

1;

# ABSTRACT: High level test functions for Markdent


__END__
=pod

=head1 NAME

Test::Markdent - High level test functions for Markdent

=head1 VERSION

version 0.14

=head1 SYNOPSIS

  use Test::Markdent;

  my $text = <<'EOF';
  Some %*em text*%
  EOF

  my $expect = [
      { type => 'paragraph' },
      [
          {
              type => 'text',
              text => 'Some %',
          }, {
              type => 'emphasis',
          },
          [
              {
                  type => 'text',
                  text => 'em text',
              },
          ], {
              type => 'text',
              text => "%\n",
          },
      ],
  ];

  parse_ok( $text, $expect, 'emphasis markup surrounded by brackets' );

=head1 DESCRIPTION

This module provides some helper functions for testing Markdent at a
higher-level. In particular, it helps generate parse trees or HTML output from
a parse.

=head1 FUNCTIONS

This class exports the following functions:

=head2 parse_ok( $markdown, $tree, $description )

This function takes some Markdown text, an expected output tree, and a
description of the test.

The tree is generated by using L<Markdent::Handler::MinimalTree>, and then
using L<Tree::Simple::Visitor::ToNestedArray> to covert the tree to a data
structure.

You can use the C<tree_from_handler> function to get the tree. You may want to
use L<Data::Dumper> to examine a few trees to understand exactly what this
looks like.

You can also pass an optional hash reference as the first parameter to this
function. This hash reference will be used as parameters when creating the
L<Markdent::Parser> object.

This hash reference can also include a "handler_class" parameter, which you
can use to override the default of L<Markdent::Handler::MinimalTree>.

If you set the C<MARKDENT_TEST_VERBOSE> environment variable to a true value,
then this function will use Data::Dumper to output the tree with
C<Test::More::diag()>.

=head2 html_output_ok( $markdown, $html, $description )

This function takes some Markdown text, the expected HTML output, and a
description of the test.

Internally, this function uses L<HTML::Tidy> to tidy both the
Markdent-generated HTML and the HTML you pass in. This ensures that the test
is comparing the HTML on a I<semantic> level.

The comparison itself is done using C<eq_or_diff> from L<Test::Differences>.

You can also pass an optional hash reference as the first parameter to this
function. This hash reference will be used as parameters when creating the
L<Markdent::Parser> object.

If you set the C<MARKDENT_TEST_VERBOSE> environment variable to a true value,
then this function will output the generated html (before tidying) with
C<Test::More::diag()>.

=head2 tree_from_handler($handler)

Given a L<Markdent::Handler::MinimalTree> object, this function returns a data
structure built using L<Tree::Simple::Visitor::ToNestedArray>.

=head1 AUTHOR

  Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

