#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use CipherLab::Cli::ArgParser;
use CipherLab::Engine::Harness;
use CipherLab::Engine::ProgressReporter;
use CipherLab::Registry::FamilyCatalog;
use CipherLab::Store::ResultsStore;
use CipherLab::Store::ResultRecord;
use CipherLab::Store::SessionState;
use CipherLab::Report::SummaryReport;
use CipherLab::Report::SuiteReport;

my $config = CipherLab::Cli::ArgParser::parse(@ARGV);
my @descriptors = CipherLab::Registry::FamilyCatalog::all();
my $reporter = CipherLab::Engine::ProgressReporter->new(scalar @descriptors);
my @outcomes = CipherLab::Engine::Harness::run_all($reporter);

my @records = map {
    CipherLab::Store::ResultRecord->new($_->family, $_->suite, 1)
} @descriptors;
CipherLab::Store::ResultsStore::persist(@records) if $config->{persist};

print CipherLab::Report::SummaryReport::build(CipherLab::Store::SessionState::previous_sessions(), @outcomes), "\n";
print CipherLab::Report::SuiteReport::build(@outcomes), "\n";
