package CipherLab::Families::LcgStream::LcgStreamBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::LcgStream::LcgStreamCipher;
use CipherLab::Families::LcgStream::LcgStreamVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::LcgStream::LcgStreamCipher->new;
    my @vectors = CipherLab::Families::LcgStream::LcgStreamVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
