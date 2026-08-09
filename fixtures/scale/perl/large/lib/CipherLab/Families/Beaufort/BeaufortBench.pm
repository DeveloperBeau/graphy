package CipherLab::Families::Beaufort::BeaufortBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Beaufort::BeaufortCipher;
use CipherLab::Families::Beaufort::BeaufortVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Beaufort::BeaufortCipher->new;
    my @vectors = CipherLab::Families::Beaufort::BeaufortVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
