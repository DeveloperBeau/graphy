package CipherLab::Families::Sdbm::SdbmDescriptor;
use strict;
use warnings;
use CipherLab::Families::Sdbm::SdbmCipher;
use CipherLab::Families::Sdbm::SdbmVectors;

# Registered once in FamilyCatalog; ties together SdbmCipher and
# SdbmVectors under the "hash" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'sdbm' }
sub suite  { return 'hash' }

sub cipher {
    return CipherLab::Families::Sdbm::SdbmCipher->new;
}

sub vectors {
    return CipherLab::Families::Sdbm::SdbmVectors::all();
}

1;
