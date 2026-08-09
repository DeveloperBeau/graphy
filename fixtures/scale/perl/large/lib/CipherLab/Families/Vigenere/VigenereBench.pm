package CipherLab::Families::Vigenere::VigenereBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Vigenere::VigenereCipher;
use CipherLab::Families::Vigenere::VigenereVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Vigenere::VigenereCipher->new;
    my @vectors = CipherLab::Families::Vigenere::VigenereVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
