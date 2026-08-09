package CipherLab::Families::Tea::TeaRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Tea::TeaCipher;
use CipherLab::Families::Tea::TeaVectors;

sub check {
    my $cipher = CipherLab::Families::Tea::TeaCipher->new;
    my @vectors = CipherLab::Families::Tea::TeaVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
