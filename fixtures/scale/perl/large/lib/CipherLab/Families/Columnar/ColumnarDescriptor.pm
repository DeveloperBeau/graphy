package CipherLab::Families::Columnar::ColumnarDescriptor;
use strict;
use warnings;
use CipherLab::Families::Columnar::ColumnarCipher;
use CipherLab::Families::Columnar::ColumnarVectors;

# Registered once in FamilyCatalog; ties together ColumnarCipher and
# ColumnarVectors under the "transposition" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'columnar' }
sub suite  { return 'transposition' }

sub cipher {
    return CipherLab::Families::Columnar::ColumnarCipher->new;
}

sub vectors {
    return CipherLab::Families::Columnar::ColumnarVectors::all();
}

1;
