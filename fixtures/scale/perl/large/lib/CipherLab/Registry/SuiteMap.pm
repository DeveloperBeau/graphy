package CipherLab::Registry::SuiteMap;
use strict;
use warnings;
use CipherLab::Registry::FamilyCatalog;

sub grouped {
    my %map;
    for my $descriptor (CipherLab::Registry::FamilyCatalog::all()) {
        push @{ $map{ $descriptor->suite } }, $descriptor;
    }
    return %map;
}

sub suite_names {
    my %map = grouped();
    return sort keys %map;
}

1;
