#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';
use Service;

my $svc = Service->new("graphy");
print $svc->run(), "\n";
