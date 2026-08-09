package CipherLab::Families::Sdbm::SdbmBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Sdbm::SdbmCipher;
use CipherLab::Families::Sdbm::SdbmVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Sdbm::SdbmCipher->new;
    my @vectors = CipherLab::Families::Sdbm::SdbmVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
