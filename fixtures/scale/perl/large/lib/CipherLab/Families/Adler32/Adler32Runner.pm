package CipherLab::Families::Adler32::Adler32Runner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Adler32::Adler32Cipher;
use CipherLab::Families::Adler32::Adler32Vectors;

sub check {
    my $cipher = CipherLab::Families::Adler32::Adler32Cipher->new;
    my @vectors = CipherLab::Families::Adler32::Adler32Vectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
