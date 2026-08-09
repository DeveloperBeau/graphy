package CipherLab::Families::Fnv1a32::Fnv1a32Bench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Fnv1a32::Fnv1a32Cipher;
use CipherLab::Families::Fnv1a32::Fnv1a32Vectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Fnv1a32::Fnv1a32Cipher->new;
    my @vectors = CipherLab::Families::Fnv1a32::Fnv1a32Vectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
