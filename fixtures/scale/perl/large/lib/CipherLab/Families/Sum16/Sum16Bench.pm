package CipherLab::Families::Sum16::Sum16Bench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Sum16::Sum16Cipher;
use CipherLab::Families::Sum16::Sum16Vectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Sum16::Sum16Cipher->new;
    my @vectors = CipherLab::Families::Sum16::Sum16Vectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
