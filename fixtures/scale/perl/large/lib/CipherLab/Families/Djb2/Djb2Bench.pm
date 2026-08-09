package CipherLab::Families::Djb2::Djb2Bench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Djb2::Djb2Cipher;
use CipherLab::Families::Djb2::Djb2Vectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Djb2::Djb2Cipher->new;
    my @vectors = CipherLab::Families::Djb2::Djb2Vectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
