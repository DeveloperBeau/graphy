package CipherLab::Families::Crc32::Crc32Bench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Crc32::Crc32Cipher;
use CipherLab::Families::Crc32::Crc32Vectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Crc32::Crc32Cipher->new;
    my @vectors = CipherLab::Families::Crc32::Crc32Vectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
