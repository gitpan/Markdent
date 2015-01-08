requires "Digest::SHA1" => "0";
requires "Exporter" => "0";
requires "File::Slurp" => "0";
requires "Getopt::Long::Descriptive" => "0";
requires "HTML::Stream" => "0";
requires "IO::Handle" => "0";
requires "List::AllUtils" => "0";
requires "Module::Runtime" => "0";
requires "Moose" => "0.92";
requires "Moose::Meta::Class" => "0";
requires "Moose::Role" => "0";
requires "MooseX::Getopt::Dashes" => "0";
requires "MooseX::Params::Validate" => "0";
requires "MooseX::Role::Parameterized" => "0";
requires "MooseX::SemiAffordanceAccessor" => "0.05";
requires "MooseX::StrictConstructor" => "0.08";
requires "MooseX::Types" => "0.20";
requires "MooseX::Types::Combine" => "0";
requires "MooseX::Types::Moose" => "0";
requires "Scalar::Util" => "0";
requires "Tree::Simple" => "0";
requires "Try::Tiny" => "0";
requires "base" => "0";
requires "namespace::autoclean" => "0.09";
requires "re" => "0";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "Data::Dumper" => "0";
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Basename" => "0";
  requires "File::Find" => "0";
  requires "File::Spec" => "0";
  requires "File::Temp" => "0";
  requires "IO::File" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Test::Deep" => "0";
  requires "Test::Fatal" => "0";
  requires "Test::More" => "0.88";
  requires "Tree::Simple::Visitor::ToNestedArray" => "0";
  requires "lib" => "0";
  requires "perl" => "5.006";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "HTML::Differences" => "0";
  requires "Pod::Coverage::Moose" => "0.02";
  requires "Test::CPAN::Changes" => "0.19";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.04";
  requires "Test::Spelling" => "0.12";
  requires "WebService::Validator::HTML::W3C" => "0";
};
