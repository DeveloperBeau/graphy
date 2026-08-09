package CipherLab::Families::Scytale::ScytaleBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Scytale::ScytaleCipher;
use CipherLab::Families::Scytale::ScytaleVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Scytale::ScytaleCipher->new;
    my @vectors = CipherLab::Families::Scytale::ScytaleVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
