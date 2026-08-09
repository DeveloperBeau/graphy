package CipherLab::Families::Atbash::AtbashRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Atbash::AtbashCipher;
use CipherLab::Families::Atbash::AtbashVectors;

sub check {
    my $cipher = CipherLab::Families::Atbash::AtbashCipher->new;
    my @vectors = CipherLab::Families::Atbash::AtbashVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
