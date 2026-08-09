package CipherLab::Families::Polybius::PolybiusDescriptor;
use strict;
use warnings;
use CipherLab::Families::Polybius::PolybiusCipher;
use CipherLab::Families::Polybius::PolybiusVectors;

# Registered once in FamilyCatalog; ties together PolybiusCipher and
# PolybiusVectors under the "classical" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'polybius' }
sub suite  { return 'classical' }

sub cipher {
    return CipherLab::Families::Polybius::PolybiusCipher->new;
}

sub vectors {
    return CipherLab::Families::Polybius::PolybiusVectors::all();
}

1;
