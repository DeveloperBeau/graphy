package CipherLab::Families::Gronsfeld::GronsfeldRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Gronsfeld::GronsfeldCipher;
use CipherLab::Families::Gronsfeld::GronsfeldVectors;

sub check {
    my $cipher = CipherLab::Families::Gronsfeld::GronsfeldCipher->new;
    my @vectors = CipherLab::Families::Gronsfeld::GronsfeldVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
