package CipherLab::Families::Scytale::ScytaleDescriptor;
use strict;
use warnings;
use CipherLab::Families::Scytale::ScytaleCipher;
use CipherLab::Families::Scytale::ScytaleVectors;

# Registered once in FamilyCatalog; ties together ScytaleCipher and
# ScytaleVectors under the "transposition" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'scytale' }
sub suite  { return 'transposition' }

sub cipher {
    return CipherLab::Families::Scytale::ScytaleCipher->new;
}

sub vectors {
    return CipherLab::Families::Scytale::ScytaleVectors::all();
}

1;
