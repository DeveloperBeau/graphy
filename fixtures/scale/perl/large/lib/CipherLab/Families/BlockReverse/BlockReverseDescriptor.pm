package CipherLab::Families::BlockReverse::BlockReverseDescriptor;
use strict;
use warnings;
use CipherLab::Families::BlockReverse::BlockReverseCipher;
use CipherLab::Families::BlockReverse::BlockReverseVectors;

# Registered once in FamilyCatalog; ties together BlockReverseCipher and
# BlockReverseVectors under the "block" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'blockreverse' }
sub suite  { return 'block' }

sub cipher {
    return CipherLab::Families::BlockReverse::BlockReverseCipher->new;
}

sub vectors {
    return CipherLab::Families::BlockReverse::BlockReverseVectors::all();
}

1;
