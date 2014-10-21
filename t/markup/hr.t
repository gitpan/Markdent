use strict;
use warnings;

use Test::More;

plan 'no_plan';

use lib 't/lib';

use Test::Markdent;

{
    my $text = <<'EOF';

---

EOF

    my $expect = [
        {
            type => 'hr',
        },
    ];

    parse_ok( $text, $expect, 'hr preceded by blank line' );
}

{
    my $text = <<'EOF';
---
EOF

    my $expect = [
        {
            type => 'hr',
        },
    ];

    parse_ok( $text, $expect, 'hr at beginning of document' );
}

{
    my $tab = "\t";

    my $text = <<"EOF";

${tab}---

EOF

    my $expect = [
        {
            type => 'preformatted',
            text => "---\n",
        },
    ];

    parse_ok( $text, $expect, 'hr cannot have a leading tab' );
}

{
    my $text = <<'EOF';

- -   ---

EOF

    my $expect = [
        {
            type => 'unordered_list',
        },
        [
            { type => 'list_item' },
            [
                {
                    type => 'text',
                    text => "-   ---\n",
                },
            ],
        ],
    ];

    parse_ok( $text, $expect, 'hr cannot have >1 space between text items' );
}


{
    my $text = <<'EOF';
************************
EOF

    my $expect = [
        {
            type => 'hr',
        },
    ];

    parse_ok( $text, $expect, 'hr at beginning of document' );
}

{
    my $text = <<'EOF';
   ************************
EOF

    my $expect = [
        {
            type => 'hr',
        },
    ];

    parse_ok( $text, $expect, 'hr with three leading spaces' );
}

{
    my $text = <<'EOF';
still an hr
* * * * * * *
and some text
EOF

    my $expect = [
        { type => 'paragraph' },
        [
            {
                type => 'text',
                text => "still an hr\n",
            },
        ],
        { type => 'hr' },
        { type => 'paragraph' },
        [
            {
                type => 'text',
                text => "and some text\n",
            },
        ],
    ];

    parse_ok( $text, $expect, 'something that could be an hr but is not' );
}
