package Calc::Functions::StandardLibrary;
use strict;
use warnings;
use Calc::Functions::FunctionRegistry;
use Calc::Functions::TrigFunctions;
use Calc::Functions::LogFunctions;
use Calc::Functions::PowerFunctions;
use Calc::Functions::RoundingFunctions;
use Calc::Functions::StatsFunctions;
use Calc::Functions::NumberFunctions;
use Calc::Functions::SequenceFunctions;

sub build_registry {
    my $registry = Calc::Functions::FunctionRegistry->new;
    Calc::Functions::TrigFunctions::install($registry);
    Calc::Functions::LogFunctions::install($registry);
    Calc::Functions::PowerFunctions::install($registry);
    Calc::Functions::RoundingFunctions::install($registry);
    Calc::Functions::StatsFunctions::install($registry);
    Calc::Functions::NumberFunctions::install($registry);
    Calc::Functions::SequenceFunctions::install($registry);
    return $registry;
}

1;
