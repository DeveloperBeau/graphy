package CipherLab::Families::Bacon::BaconDescriptor;
use strict;
use warnings;
use CipherLab::Families::Bacon::BaconCipher;
use CipherLab::Families::Bacon::BaconVectors;

# Registered once in FamilyCatalog; ties together BaconCipher and
# BaconVectors under the "classical" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'bacon' }
sub suite  { return 'classical' }

sub cipher {
    return CipherLab::Families::Bacon::BaconCipher->new;
}

sub vectors {
    return CipherLab::Families::Bacon::BaconVectors::all();
}

1;
