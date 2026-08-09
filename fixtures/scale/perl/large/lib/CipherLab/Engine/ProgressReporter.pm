package CipherLab::Engine::ProgressReporter;
use strict;
use warnings;

sub new {
    my ($class, $total) = @_;
    return bless { total => $total, done => 0 }, $class;
}

sub step {
    my ($self, $family, $passed) = @_;
    $self->{done}++;
    my $flag = $passed ? 'ok ' : 'BAD';
    print STDERR "\r[$self->{done}/$self->{total}] $flag $family        ";
    print STDERR "\n" if $self->{done} == $self->{total};
}

1;
