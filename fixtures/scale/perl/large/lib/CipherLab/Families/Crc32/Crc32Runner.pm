package CipherLab::Families::Crc32::Crc32Runner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Crc32::Crc32Cipher;
use CipherLab::Families::Crc32::Crc32Vectors;

sub check {
    my $cipher = CipherLab::Families::Crc32::Crc32Cipher->new;
    my @vectors = CipherLab::Families::Crc32::Crc32Vectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
