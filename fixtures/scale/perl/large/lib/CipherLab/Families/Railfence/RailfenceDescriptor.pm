package CipherLab::Families::Railfence::RailfenceDescriptor;
use strict;
use warnings;
use CipherLab::Families::Railfence::RailfenceCipher;
use CipherLab::Families::Railfence::RailfenceVectors;

# Registered once in FamilyCatalog; ties together RailfenceCipher and
# RailfenceVectors under the "transposition" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'railfence' }
sub suite  { return 'transposition' }

sub cipher {
    return CipherLab::Families::Railfence::RailfenceCipher->new;
}

sub vectors {
    return CipherLab::Families::Railfence::RailfenceVectors::all();
}

1;
