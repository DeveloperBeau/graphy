package CipherLab::Families::Scytale::ScytaleRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Scytale::ScytaleCipher;
use CipherLab::Families::Scytale::ScytaleVectors;

sub check {
    my $cipher = CipherLab::Families::Scytale::ScytaleCipher->new;
    my @vectors = CipherLab::Families::Scytale::ScytaleVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
