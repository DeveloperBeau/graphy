package CipherLab::Families::Substitution::SubstitutionDescriptor;
use strict;
use warnings;
use CipherLab::Families::Substitution::SubstitutionCipher;
use CipherLab::Families::Substitution::SubstitutionVectors;

# Registered once in FamilyCatalog; ties together SubstitutionCipher and
# SubstitutionVectors under the "classical" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'substitution' }
sub suite  { return 'classical' }

sub cipher {
    return CipherLab::Families::Substitution::SubstitutionCipher->new;
}

sub vectors {
    return CipherLab::Families::Substitution::SubstitutionVectors::all();
}

1;
