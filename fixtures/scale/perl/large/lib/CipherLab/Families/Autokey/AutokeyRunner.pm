package CipherLab::Families::Autokey::AutokeyRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Autokey::AutokeyCipher;
use CipherLab::Families::Autokey::AutokeyVectors;

sub check {
    my $cipher = CipherLab::Families::Autokey::AutokeyCipher->new;
    my @vectors = CipherLab::Families::Autokey::AutokeyVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
