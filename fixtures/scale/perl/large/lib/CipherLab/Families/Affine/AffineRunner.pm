package CipherLab::Families::Affine::AffineRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Affine::AffineCipher;
use CipherLab::Families::Affine::AffineVectors;

sub check {
    my $cipher = CipherLab::Families::Affine::AffineCipher->new;
    my @vectors = CipherLab::Families::Affine::AffineVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
