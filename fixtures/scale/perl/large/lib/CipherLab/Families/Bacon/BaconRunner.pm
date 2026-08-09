package CipherLab::Families::Bacon::BaconRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Bacon::BaconCipher;
use CipherLab::Families::Bacon::BaconVectors;

sub check {
    my $cipher = CipherLab::Families::Bacon::BaconCipher->new;
    my @vectors = CipherLab::Families::Bacon::BaconVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
