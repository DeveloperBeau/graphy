package CipherLab::Families::LcgStream::LcgStreamRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::LcgStream::LcgStreamCipher;
use CipherLab::Families::LcgStream::LcgStreamVectors;

sub check {
    my $cipher = CipherLab::Families::LcgStream::LcgStreamCipher->new;
    my @vectors = CipherLab::Families::LcgStream::LcgStreamVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
