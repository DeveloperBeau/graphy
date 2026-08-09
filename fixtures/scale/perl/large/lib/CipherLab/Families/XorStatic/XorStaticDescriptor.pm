package CipherLab::Families::XorStatic::XorStaticDescriptor;
use strict;
use warnings;
use CipherLab::Families::XorStatic::XorStaticCipher;
use CipherLab::Families::XorStatic::XorStaticVectors;

# Registered once in FamilyCatalog; ties together XorStaticCipher and
# XorStaticVectors under the "stream" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'xorstatic' }
sub suite  { return 'stream' }

sub cipher {
    return CipherLab::Families::XorStatic::XorStaticCipher->new;
}

sub vectors {
    return CipherLab::Families::XorStatic::XorStaticVectors::all();
}

1;
