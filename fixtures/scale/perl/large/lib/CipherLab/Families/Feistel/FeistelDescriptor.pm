package CipherLab::Families::Feistel::FeistelDescriptor;
use strict;
use warnings;
use CipherLab::Families::Feistel::FeistelCipher;
use CipherLab::Families::Feistel::FeistelVectors;

# Registered once in FamilyCatalog; ties together FeistelCipher and
# FeistelVectors under the "block" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'feistel' }
sub suite  { return 'block' }

sub cipher {
    return CipherLab::Families::Feistel::FeistelCipher->new;
}

sub vectors {
    return CipherLab::Families::Feistel::FeistelVectors::all();
}

1;
