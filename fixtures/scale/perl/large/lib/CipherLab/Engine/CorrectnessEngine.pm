package CipherLab::Engine::CorrectnessEngine;
use strict;
use warnings;
use CipherLab::VectorOutcome;

sub verify {
    my ($cipher, @vectors) = @_;
    for my $vector (@vectors) {
        my $encoded = $cipher->encode($vector->plaintext);
        if ($encoded ne $vector->expected) {
            return CipherLab::VectorOutcome->new($cipher->name, 0, 'encode mismatch for ' . $vector->plaintext);
        }
        my $decoded = $cipher->decode($encoded);
        if ($decoded eq '' && $vector->plaintext ne '') {
            return CipherLab::VectorOutcome->new($cipher->name, 0, 'empty decode');
        }
    }
    return CipherLab::VectorOutcome->new($cipher->name, 1, 'ok');
}

1;
