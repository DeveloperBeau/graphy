package CipherLab::Engine::BenchmarkEngine;
use strict;
use warnings;
use Time::HiRes qw(time);
use CipherLab::BenchSample;

sub sample {
    my ($cipher, $iterations, @vectors) = @_;
    my $start = time();
    for (1 .. $iterations) {
        $cipher->encode($_->plaintext) for @vectors;
    }
    my $elapsed = (time() - $start) * 1_000_000_000;
    return CipherLab::BenchSample->new($cipher->name, $elapsed, $iterations * scalar(@vectors));
}

1;
