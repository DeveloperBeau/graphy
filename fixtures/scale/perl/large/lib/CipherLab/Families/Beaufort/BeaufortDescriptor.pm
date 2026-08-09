package CipherLab::Families::Beaufort::BeaufortDescriptor;
use strict;
use warnings;
use CipherLab::Families::Beaufort::BeaufortCipher;
use CipherLab::Families::Beaufort::BeaufortVectors;

# Registered once in FamilyCatalog; ties together BeaufortCipher and
# BeaufortVectors under the "polyalphabetic" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'beaufort' }
sub suite  { return 'polyalphabetic' }

sub cipher {
    return CipherLab::Families::Beaufort::BeaufortCipher->new;
}

sub vectors {
    return CipherLab::Families::Beaufort::BeaufortVectors::all();
}

1;
