package CipherLab::Families::Trithemius::TrithemiusDescriptor;
use strict;
use warnings;
use CipherLab::Families::Trithemius::TrithemiusCipher;
use CipherLab::Families::Trithemius::TrithemiusVectors;

# Registered once in FamilyCatalog; ties together TrithemiusCipher and
# TrithemiusVectors under the "polyalphabetic" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'trithemius' }
sub suite  { return 'polyalphabetic' }

sub cipher {
    return CipherLab::Families::Trithemius::TrithemiusCipher->new;
}

sub vectors {
    return CipherLab::Families::Trithemius::TrithemiusVectors::all();
}

1;
