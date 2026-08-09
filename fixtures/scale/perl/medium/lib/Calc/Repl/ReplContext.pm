package Calc::Repl::ReplContext;
use strict;
use warnings;
use Calc::Eval::Environment;
use Calc::Functions::StandardLibrary;
use Calc::Memory::HistoryLog;

sub new {
    my ($class, $settings) = @_;
    return bless {
        environment => Calc::Eval::Environment->new,
        functions   => Calc::Functions::StandardLibrary::build_registry(),
        history     => Calc::Memory::HistoryLog->new,
        settings    => $settings,
    }, $class;
}

sub environment { return $_[0]->{environment} }
sub functions   { return $_[0]->{functions} }
sub history     { return $_[0]->{history} }
sub settings    { return $_[0]->{settings} }

1;
