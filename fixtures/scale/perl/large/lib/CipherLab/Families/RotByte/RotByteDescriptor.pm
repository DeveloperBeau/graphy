package CipherLab::Families::RotByte::RotByteDescriptor;
use strict;
use warnings;
use CipherLab::Families::RotByte::RotByteCipher;
use CipherLab::Families::RotByte::RotByteVectors;

# Registered once in FamilyCatalog; ties together RotByteCipher and
# RotByteVectors under the "stream" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'rotbyte' }
sub suite  { return 'stream' }

sub cipher {
    return CipherLab::Families::RotByte::RotByteCipher->new;
}

sub vectors {
    return CipherLab::Families::RotByte::RotByteVectors::all();
}

1;
