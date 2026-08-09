#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Calc::Version;
use Calc::Settings;
use Calc::Repl::ReplContext;
use Calc::Repl::Repl;

print Calc::Version::banner(), "\n";
my $settings = Calc::Settings::interactive();
my $context = Calc::Repl::ReplContext->new($settings);
Calc::Repl::Repl->new($context)->run;
