package CipherLab::Families::Adler32::Adler32Descriptor;
use strict;
use warnings;
use CipherLab::Families::Adler32::Adler32Cipher;
use CipherLab::Families::Adler32::Adler32Vectors;

# Registered once in FamilyCatalog; ties together Adler32Cipher and
# Adler32Vectors under the "hash" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'adler32' }
sub suite  { return 'hash' }

sub cipher {
    return CipherLab::Families::Adler32::Adler32Cipher->new;
}

sub vectors {
    return CipherLab::Families::Adler32::Adler32Vectors::all();
}

1;
