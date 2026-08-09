package CipherLab::Families::NibbleSwap::NibbleSwapDescriptor;
use strict;
use warnings;
use CipherLab::Families::NibbleSwap::NibbleSwapCipher;
use CipherLab::Families::NibbleSwap::NibbleSwapVectors;

# Registered once in FamilyCatalog; ties together NibbleSwapCipher and
# NibbleSwapVectors under the "stream" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'nibbleswap' }
sub suite  { return 'stream' }

sub cipher {
    return CipherLab::Families::NibbleSwap::NibbleSwapCipher->new;
}

sub vectors {
    return CipherLab::Families::NibbleSwap::NibbleSwapVectors::all();
}

1;
