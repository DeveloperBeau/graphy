package CipherLab::Families::Keyword::KeywordBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Keyword::KeywordCipher;
use CipherLab::Families::Keyword::KeywordVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Keyword::KeywordCipher->new;
    my @vectors = CipherLab::Families::Keyword::KeywordVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
