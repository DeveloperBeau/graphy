package CipherLab::Families::Rot13::Rot13Bench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Rot13::Rot13Cipher;
use CipherLab::Families::Rot13::Rot13Vectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Rot13::Rot13Cipher->new;
    my @vectors = CipherLab::Families::Rot13::Rot13Vectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
