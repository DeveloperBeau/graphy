package CipherLab::Families::Autokey::AutokeyBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Autokey::AutokeyCipher;
use CipherLab::Families::Autokey::AutokeyVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Autokey::AutokeyCipher->new;
    my @vectors = CipherLab::Families::Autokey::AutokeyVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
