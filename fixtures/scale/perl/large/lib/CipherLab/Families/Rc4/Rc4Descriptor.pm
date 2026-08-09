package CipherLab::Families::Rc4::Rc4Descriptor;
use strict;
use warnings;
use CipherLab::Families::Rc4::Rc4Cipher;
use CipherLab::Families::Rc4::Rc4Vectors;

# Registered once in FamilyCatalog; ties together Rc4Cipher and
# Rc4Vectors under the "stream" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'rc4' }
sub suite  { return 'stream' }

sub cipher {
    return CipherLab::Families::Rc4::Rc4Cipher->new;
}

sub vectors {
    return CipherLab::Families::Rc4::Rc4Vectors::all();
}

1;
