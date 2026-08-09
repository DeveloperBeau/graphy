package CipherLab::Families::Railfence::RailfenceBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Railfence::RailfenceCipher;
use CipherLab::Families::Railfence::RailfenceVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Railfence::RailfenceCipher->new;
    my @vectors = CipherLab::Families::Railfence::RailfenceVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
