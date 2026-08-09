package CipherLab::Families::Gronsfeld::GronsfeldDescriptor;
use strict;
use warnings;
use CipherLab::Families::Gronsfeld::GronsfeldCipher;
use CipherLab::Families::Gronsfeld::GronsfeldVectors;

# Registered once in FamilyCatalog; ties together GronsfeldCipher and
# GronsfeldVectors under the "polyalphabetic" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'gronsfeld' }
sub suite  { return 'polyalphabetic' }

sub cipher {
    return CipherLab::Families::Gronsfeld::GronsfeldCipher->new;
}

sub vectors {
    return CipherLab::Families::Gronsfeld::GronsfeldVectors::all();
}

1;
