package CipherLab::Cli::ArgParser;
use strict;
use warnings;
use CipherLab::Cli::Config;

sub parse {
    my (@args) = @_;
    my $config = CipherLab::Cli::Config::defaults();
    for (my $i = 0; $i < @args; $i++) {
        if    ($args[$i] eq '--iterations') { $config->{iterations}  = $args[++$i] }
        elsif ($args[$i] eq '--suite')      { $config->{suiteFilter} = $args[++$i] }
        elsif ($args[$i] eq '--no-persist') { $config->{persist}     = 0 }
    }
    return $config;
}

1;
