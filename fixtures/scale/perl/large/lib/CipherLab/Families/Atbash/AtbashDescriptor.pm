package CipherLab::Families::Atbash::AtbashDescriptor;
use strict;
use warnings;
use CipherLab::Families::Atbash::AtbashCipher;
use CipherLab::Families::Atbash::AtbashVectors;

# Registered once in FamilyCatalog; ties together AtbashCipher and
# AtbashVectors under the "classical" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'atbash' }
sub suite  { return 'classical' }

sub cipher {
    return CipherLab::Families::Atbash::AtbashCipher->new;
}

sub vectors {
    return CipherLab::Families::Atbash::AtbashVectors::all();
}

1;
