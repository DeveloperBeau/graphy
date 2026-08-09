package CipherLab::Families::Trithemius::TrithemiusRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Trithemius::TrithemiusCipher;
use CipherLab::Families::Trithemius::TrithemiusVectors;

sub check {
    my $cipher = CipherLab::Families::Trithemius::TrithemiusCipher->new;
    my @vectors = CipherLab::Families::Trithemius::TrithemiusVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
