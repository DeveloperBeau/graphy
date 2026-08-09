package CipherLab::Families::Affine::AffineBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Affine::AffineCipher;
use CipherLab::Families::Affine::AffineVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Affine::AffineCipher->new;
    my @vectors = CipherLab::Families::Affine::AffineVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
