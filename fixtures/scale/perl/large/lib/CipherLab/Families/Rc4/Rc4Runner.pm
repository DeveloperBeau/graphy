package CipherLab::Families::Rc4::Rc4Runner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Rc4::Rc4Cipher;
use CipherLab::Families::Rc4::Rc4Vectors;

sub check {
    my $cipher = CipherLab::Families::Rc4::Rc4Cipher->new;
    my @vectors = CipherLab::Families::Rc4::Rc4Vectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
