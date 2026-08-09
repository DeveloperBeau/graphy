package CipherLab::Families::Railfence::RailfenceRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Railfence::RailfenceCipher;
use CipherLab::Families::Railfence::RailfenceVectors;

sub check {
    my $cipher = CipherLab::Families::Railfence::RailfenceCipher->new;
    my @vectors = CipherLab::Families::Railfence::RailfenceVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
