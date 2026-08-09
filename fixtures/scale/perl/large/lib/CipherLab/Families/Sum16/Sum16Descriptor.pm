package CipherLab::Families::Sum16::Sum16Descriptor;
use strict;
use warnings;
use CipherLab::Families::Sum16::Sum16Cipher;
use CipherLab::Families::Sum16::Sum16Vectors;

# Registered once in FamilyCatalog; ties together Sum16Cipher and
# Sum16Vectors under the "hash" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'sum16' }
sub suite  { return 'hash' }

sub cipher {
    return CipherLab::Families::Sum16::Sum16Cipher->new;
}

sub vectors {
    return CipherLab::Families::Sum16::Sum16Vectors::all();
}

1;
