
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.06

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'bin/markdent-html',
    'lib/Markdent.pm',
    'lib/Markdent/CLI.pm',
    'lib/Markdent/CapturedEvents.pm',
    'lib/Markdent/Dialect/GitHub.pod',
    'lib/Markdent/Dialect/GitHub/BlockParser.pm',
    'lib/Markdent/Dialect/GitHub/SpanParser.pm',
    'lib/Markdent/Dialect/Standard.pod',
    'lib/Markdent/Dialect/Theory.pod',
    'lib/Markdent/Dialect/Theory/BlockParser.pm',
    'lib/Markdent/Dialect/Theory/SpanParser.pm',
    'lib/Markdent/Event/AutoLink.pm',
    'lib/Markdent/Event/CodeBlock.pm',
    'lib/Markdent/Event/EndBlockquote.pm',
    'lib/Markdent/Event/EndCode.pm',
    'lib/Markdent/Event/EndDocument.pm',
    'lib/Markdent/Event/EndEmphasis.pm',
    'lib/Markdent/Event/EndHTMLTag.pm',
    'lib/Markdent/Event/EndHeader.pm',
    'lib/Markdent/Event/EndLink.pm',
    'lib/Markdent/Event/EndListItem.pm',
    'lib/Markdent/Event/EndOrderedList.pm',
    'lib/Markdent/Event/EndParagraph.pm',
    'lib/Markdent/Event/EndStrong.pm',
    'lib/Markdent/Event/EndTable.pm',
    'lib/Markdent/Event/EndTableBody.pm',
    'lib/Markdent/Event/EndTableCell.pm',
    'lib/Markdent/Event/EndTableHeader.pm',
    'lib/Markdent/Event/EndTableRow.pm',
    'lib/Markdent/Event/EndUnorderedList.pm',
    'lib/Markdent/Event/HTMLBlock.pm',
    'lib/Markdent/Event/HTMLComment.pm',
    'lib/Markdent/Event/HTMLCommentBlock.pm',
    'lib/Markdent/Event/HTMLEntity.pm',
    'lib/Markdent/Event/HTMLTag.pm',
    'lib/Markdent/Event/HorizontalRule.pm',
    'lib/Markdent/Event/Image.pm',
    'lib/Markdent/Event/LineBreak.pm',
    'lib/Markdent/Event/Preformatted.pm',
    'lib/Markdent/Event/StartBlockquote.pm',
    'lib/Markdent/Event/StartCode.pm',
    'lib/Markdent/Event/StartDocument.pm',
    'lib/Markdent/Event/StartEmphasis.pm',
    'lib/Markdent/Event/StartHTMLTag.pm',
    'lib/Markdent/Event/StartHeader.pm',
    'lib/Markdent/Event/StartLink.pm',
    'lib/Markdent/Event/StartListItem.pm',
    'lib/Markdent/Event/StartOrderedList.pm',
    'lib/Markdent/Event/StartParagraph.pm',
    'lib/Markdent/Event/StartStrong.pm',
    'lib/Markdent/Event/StartTable.pm',
    'lib/Markdent/Event/StartTableBody.pm',
    'lib/Markdent/Event/StartTableCell.pm',
    'lib/Markdent/Event/StartTableHeader.pm',
    'lib/Markdent/Event/StartTableRow.pm',
    'lib/Markdent/Event/StartUnorderedList.pm',
    'lib/Markdent/Event/Text.pm',
    'lib/Markdent/Handler/CaptureEvents.pm',
    'lib/Markdent/Handler/HTMLFilter.pm',
    'lib/Markdent/Handler/HTMLStream/Document.pm',
    'lib/Markdent/Handler/HTMLStream/Fragment.pm',
    'lib/Markdent/Handler/MinimalTree.pm',
    'lib/Markdent/Handler/Multiplexer.pm',
    'lib/Markdent/Handler/Null.pm',
    'lib/Markdent/Manual.pod',
    'lib/Markdent/Parser.pm',
    'lib/Markdent/Parser/BlockParser.pm',
    'lib/Markdent/Parser/SpanParser.pm',
    'lib/Markdent/Regexes.pm',
    'lib/Markdent/Role/AnyParser.pm',
    'lib/Markdent/Role/BalancedEvent.pm',
    'lib/Markdent/Role/BlockParser.pm',
    'lib/Markdent/Role/DebugPrinter.pm',
    'lib/Markdent/Role/Dialect/BlockParser.pm',
    'lib/Markdent/Role/Dialect/SpanParser.pm',
    'lib/Markdent/Role/Event.pm',
    'lib/Markdent/Role/EventAsText.pm',
    'lib/Markdent/Role/EventsAsMethods.pm',
    'lib/Markdent/Role/FilterHandler.pm',
    'lib/Markdent/Role/HTMLStream.pm',
    'lib/Markdent/Role/Handler.pm',
    'lib/Markdent/Role/Simple.pm',
    'lib/Markdent/Role/SpanParser.pm',
    'lib/Markdent/Simple/Document.pm',
    'lib/Markdent/Simple/Fragment.pm',
    'lib/Markdent/Types.pm',
    'lib/Markdent/Types/Internal.pm'
);

notabs_ok($_) foreach @files;
done_testing;
