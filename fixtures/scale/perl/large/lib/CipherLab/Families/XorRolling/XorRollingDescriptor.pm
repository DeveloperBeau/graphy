package CipherLab::Families::XorRolling::XorRollingDescriptor;
use strict;
use warnings;
use CipherLab::Families::XorRolling::XorRollingCipher;
use CipherLab::Families::XorRolling::XorRollingVectors;

# Registered once in FamilyCatalog; ties together XorRollingCipher and
# XorRollingVectors under the "stream" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'xorrolling' }
sub suite  { return 'stream' }

sub cipher {
    return CipherLab::Families::XorRolling::XorRollingCipher->new;
}

sub vectors {
    return CipherLab::Families::XorRolling::XorRollingVectors::all();
}

1;
