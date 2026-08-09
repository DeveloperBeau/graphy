package CipherLab::Families::RotByte::RotByteBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::RotByte::RotByteCipher;
use CipherLab::Families::RotByte::RotByteVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::RotByte::RotByteCipher->new;
    my @vectors = CipherLab::Families::RotByte::RotByteVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
