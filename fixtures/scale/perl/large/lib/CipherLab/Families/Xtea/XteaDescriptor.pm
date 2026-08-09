package CipherLab::Families::Xtea::XteaDescriptor;
use strict;
use warnings;
use CipherLab::Families::Xtea::XteaCipher;
use CipherLab::Families::Xtea::XteaVectors;

# Registered once in FamilyCatalog; ties together XteaCipher and
# XteaVectors under the "block" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'xtea' }
sub suite  { return 'block' }

sub cipher {
    return CipherLab::Families::Xtea::XteaCipher->new;
}

sub vectors {
    return CipherLab::Families::Xtea::XteaVectors::all();
}

1;
