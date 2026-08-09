package CipherLab::Families::Vigenere::VigenereDescriptor;
use strict;
use warnings;
use CipherLab::Families::Vigenere::VigenereCipher;
use CipherLab::Families::Vigenere::VigenereVectors;

# Registered once in FamilyCatalog; ties together VigenereCipher and
# VigenereVectors under the "polyalphabetic" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'vigenere' }
sub suite  { return 'polyalphabetic' }

sub cipher {
    return CipherLab::Families::Vigenere::VigenereCipher->new;
}

sub vectors {
    return CipherLab::Families::Vigenere::VigenereVectors::all();
}

1;
