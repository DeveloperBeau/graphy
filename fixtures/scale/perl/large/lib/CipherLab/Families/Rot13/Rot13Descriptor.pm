package CipherLab::Families::Rot13::Rot13Descriptor;
use strict;
use warnings;
use CipherLab::Families::Rot13::Rot13Cipher;
use CipherLab::Families::Rot13::Rot13Vectors;

# Registered once in FamilyCatalog; ties together Rot13Cipher and
# Rot13Vectors under the "classical" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'rot13' }
sub suite  { return 'classical' }

sub cipher {
    return CipherLab::Families::Rot13::Rot13Cipher->new;
}

sub vectors {
    return CipherLab::Families::Rot13::Rot13Vectors::all();
}

1;
