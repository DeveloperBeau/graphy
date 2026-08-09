package CipherLab::Families::Tea::TeaDescriptor;
use strict;
use warnings;
use CipherLab::Families::Tea::TeaCipher;
use CipherLab::Families::Tea::TeaVectors;

# Registered once in FamilyCatalog; ties together TeaCipher and
# TeaVectors under the "block" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'tea' }
sub suite  { return 'block' }

sub cipher {
    return CipherLab::Families::Tea::TeaCipher->new;
}

sub vectors {
    return CipherLab::Families::Tea::TeaVectors::all();
}

1;
