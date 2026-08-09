package CipherLab::Families::Crc32::Crc32Descriptor;
use strict;
use warnings;
use CipherLab::Families::Crc32::Crc32Cipher;
use CipherLab::Families::Crc32::Crc32Vectors;

# Registered once in FamilyCatalog; ties together Crc32Cipher and
# Crc32Vectors under the "hash" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'crc32' }
sub suite  { return 'hash' }

sub cipher {
    return CipherLab::Families::Crc32::Crc32Cipher->new;
}

sub vectors {
    return CipherLab::Families::Crc32::Crc32Vectors::all();
}

1;
