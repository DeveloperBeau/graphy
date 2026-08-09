#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use TextPrint::ArgParser;
use TextPrint::Renderer;
use TextPrint::InputReader;

my $options = TextPrint::ArgParser::parse(@ARGV);
my $text = TextPrint::InputReader::read_all() || 'a small text printer demo for testing wrap and borders';
my $renderer = TextPrint::Renderer->new($options);
print $renderer->render($text), "\n";
