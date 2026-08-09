package CipherLab::Families::Rc4::Rc4Bench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Rc4::Rc4Cipher;
use CipherLab::Families::Rc4::Rc4Vectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Rc4::Rc4Cipher->new;
    my @vectors = CipherLab::Families::Rc4::Rc4Vectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
