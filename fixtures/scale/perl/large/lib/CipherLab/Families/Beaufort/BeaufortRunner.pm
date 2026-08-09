package CipherLab::Families::Beaufort::BeaufortRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Beaufort::BeaufortCipher;
use CipherLab::Families::Beaufort::BeaufortVectors;

sub check {
    my $cipher = CipherLab::Families::Beaufort::BeaufortCipher->new;
    my @vectors = CipherLab::Families::Beaufort::BeaufortVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
