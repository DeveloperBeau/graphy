package CipherLab::Families::Djb2::Djb2Descriptor;
use strict;
use warnings;
use CipherLab::Families::Djb2::Djb2Cipher;
use CipherLab::Families::Djb2::Djb2Vectors;

# Registered once in FamilyCatalog; ties together Djb2Cipher and
# Djb2Vectors under the "hash" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'djb2' }
sub suite  { return 'hash' }

sub cipher {
    return CipherLab::Families::Djb2::Djb2Cipher->new;
}

sub vectors {
    return CipherLab::Families::Djb2::Djb2Vectors::all();
}

1;
