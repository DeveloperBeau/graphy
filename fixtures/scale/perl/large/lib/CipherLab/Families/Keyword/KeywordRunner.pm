package CipherLab::Families::Keyword::KeywordRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Keyword::KeywordCipher;
use CipherLab::Families::Keyword::KeywordVectors;

sub check {
    my $cipher = CipherLab::Families::Keyword::KeywordCipher->new;
    my @vectors = CipherLab::Families::Keyword::KeywordVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
