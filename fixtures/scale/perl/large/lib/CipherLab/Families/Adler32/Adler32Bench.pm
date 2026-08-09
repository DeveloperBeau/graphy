package CipherLab::Families::Adler32::Adler32Bench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Adler32::Adler32Cipher;
use CipherLab::Families::Adler32::Adler32Vectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Adler32::Adler32Cipher->new;
    my @vectors = CipherLab::Families::Adler32::Adler32Vectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
