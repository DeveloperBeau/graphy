package CipherLab::Families::LcgStream::LcgStreamDescriptor;
use strict;
use warnings;
use CipherLab::Families::LcgStream::LcgStreamCipher;
use CipherLab::Families::LcgStream::LcgStreamVectors;

# Registered once in FamilyCatalog; ties together LcgStreamCipher and
# LcgStreamVectors under the "stream" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'lcgstream' }
sub suite  { return 'stream' }

sub cipher {
    return CipherLab::Families::LcgStream::LcgStreamCipher->new;
}

sub vectors {
    return CipherLab::Families::LcgStream::LcgStreamVectors::all();
}

1;
