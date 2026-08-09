package CipherLab::Families::Atbash::AtbashBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Atbash::AtbashCipher;
use CipherLab::Families::Atbash::AtbashVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Atbash::AtbashCipher->new;
    my @vectors = CipherLab::Families::Atbash::AtbashVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
