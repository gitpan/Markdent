
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "An event-based Markdown parser toolkit",
  "AUTHOR" => "Dave Rolsky <autarch\@urth.org>",
  "BUILD_REQUIRES" => {
    "Data::Dumper" => 0,
    "File::Basename" => 0,
    "File::Find" => 0,
    "File::Temp" => 0,
    "IO::File" => 0,
    "Test::Deep" => 0,
    "Test::Differences" => 0,
    "Test::Fatal" => 0,
    "Test::More" => "0.88",
    "Tree::Simple::Visitor::ToNestedArray" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Markdent",
  "EXE_FILES" => [
    "bin/markdent-html"
  ],
  "LICENSE" => "perl",
  "NAME" => "Markdent",
  "PREREQ_PM" => {
    "Class::Load" => 0,
    "Digest::SHA1" => 0,
    "Exporter" => 0,
    "File::Slurp" => 0,
    "Getopt::Long" => 0,
    "HTML::Stream" => 0,
    "IO::Handle" => 0,
    "List::AllUtils" => 0,
    "Moose" => "0.92",
    "Moose::Role" => 0,
    "MooseX::Params::Validate" => 0,
    "MooseX::Role::Parameterized" => 0,
    "MooseX::SemiAffordanceAccessor" => "0.05",
    "MooseX::StrictConstructor" => "0.08",
    "MooseX::Types" => "0.20",
    "MooseX::Types::Combine" => 0,
    "MooseX::Types::Moose" => 0,
    "Scalar::Util" => 0,
    "Tree::Simple" => 0,
    "Try::Tiny" => 0,
    "base" => 0,
    "namespace::autoclean" => "0.09",
    "re" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.19",
  "test" => {
    "TESTS" => "t/*.t t/Handler/*.t t/Handler/HTMLStream/*.t t/Simple/*.t t/markup/standard/*.t t/markup/theory/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



