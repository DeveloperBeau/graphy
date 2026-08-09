package CipherLab::Families::Autokey::AutokeyDescriptor;
use strict;
use warnings;
use CipherLab::Families::Autokey::AutokeyCipher;
use CipherLab::Families::Autokey::AutokeyVectors;

# Registered once in FamilyCatalog; ties together AutokeyCipher and
# AutokeyVectors under the "polyalphabetic" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'autokey' }
sub suite  { return 'polyalphabetic' }

sub cipher {
    return CipherLab::Families::Autokey::AutokeyCipher->new;
}

sub vectors {
    return CipherLab::Families::Autokey::AutokeyVectors::all();
}

1;
