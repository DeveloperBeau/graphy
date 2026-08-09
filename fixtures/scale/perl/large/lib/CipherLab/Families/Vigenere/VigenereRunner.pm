package CipherLab::Families::Vigenere::VigenereRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Vigenere::VigenereCipher;
use CipherLab::Families::Vigenere::VigenereVectors;

sub check {
    my $cipher = CipherLab::Families::Vigenere::VigenereCipher->new;
    my @vectors = CipherLab::Families::Vigenere::VigenereVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
