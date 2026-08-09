package CipherLab::Families::Gronsfeld::GronsfeldBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Gronsfeld::GronsfeldCipher;
use CipherLab::Families::Gronsfeld::GronsfeldVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Gronsfeld::GronsfeldCipher->new;
    my @vectors = CipherLab::Families::Gronsfeld::GronsfeldVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
