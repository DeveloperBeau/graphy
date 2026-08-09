package CipherLab::Families::Affine::AffineDescriptor;
use strict;
use warnings;
use CipherLab::Families::Affine::AffineCipher;
use CipherLab::Families::Affine::AffineVectors;

# Registered once in FamilyCatalog; ties together AffineCipher and
# AffineVectors under the "classical" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'affine' }
sub suite  { return 'classical' }

sub cipher {
    return CipherLab::Families::Affine::AffineCipher->new;
}

sub vectors {
    return CipherLab::Families::Affine::AffineVectors::all();
}

1;
