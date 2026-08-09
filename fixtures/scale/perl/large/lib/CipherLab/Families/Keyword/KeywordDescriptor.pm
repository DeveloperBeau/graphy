package CipherLab::Families::Keyword::KeywordDescriptor;
use strict;
use warnings;
use CipherLab::Families::Keyword::KeywordCipher;
use CipherLab::Families::Keyword::KeywordVectors;

# Registered once in FamilyCatalog; ties together KeywordCipher and
# KeywordVectors under the "classical" suite.
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

sub family { return 'keyword' }
sub suite  { return 'classical' }

sub cipher {
    return CipherLab::Families::Keyword::KeywordCipher->new;
}

sub vectors {
    return CipherLab::Families::Keyword::KeywordVectors::all();
}

1;
