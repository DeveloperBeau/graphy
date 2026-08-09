package CipherLab::Families::Sdbm::SdbmRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Sdbm::SdbmCipher;
use CipherLab::Families::Sdbm::SdbmVectors;

sub check {
    my $cipher = CipherLab::Families::Sdbm::SdbmCipher->new;
    my @vectors = CipherLab::Families::Sdbm::SdbmVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
