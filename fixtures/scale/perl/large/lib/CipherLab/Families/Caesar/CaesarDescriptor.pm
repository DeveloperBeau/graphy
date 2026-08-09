package CipherLab::Families::Caesar::CaesarDescriptor;
use strict;
use warnings;
use CipherLab::Families::Caesar::CaesarCipher;
use CipherLab::Families::Caesar::CaesarVectors;

# Registered once in FamilyCatalog; ties together CaesarCipher and
# CaesarVectors under the "classical" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'caesar' }
sub suite  { return 'classical' }

sub cipher {
    return CipherLab::Families::Caesar::CaesarCipher->new;
}

sub vectors {
    return CipherLab::Families::Caesar::CaesarVectors::all();
}

1;
