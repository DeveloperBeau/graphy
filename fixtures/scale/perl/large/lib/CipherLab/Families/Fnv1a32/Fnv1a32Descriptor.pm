package CipherLab::Families::Fnv1a32::Fnv1a32Descriptor;
use strict;
use warnings;
use CipherLab::Families::Fnv1a32::Fnv1a32Cipher;
use CipherLab::Families::Fnv1a32::Fnv1a32Vectors;

# Registered once in FamilyCatalog; ties together Fnv1a32Cipher and
# Fnv1a32Vectors under the "hash" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'fnv1a32' }
sub suite  { return 'hash' }

sub cipher {
    return CipherLab::Families::Fnv1a32::Fnv1a32Cipher->new;
}

sub vectors {
    return CipherLab::Families::Fnv1a32::Fnv1a32Vectors::all();
}

1;
