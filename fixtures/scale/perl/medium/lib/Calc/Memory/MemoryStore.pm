package Calc::Memory::MemoryStore;
use strict;
use warnings;

sub new { return bless { slot => 0 }, shift }

sub store      { $_[0]->{slot} = $_[1] }
sub recall     { return $_[0]->{slot} }
sub accumulate { $_[0]->{slot} += $_[1] }
sub clear      { $_[0]->{slot} = 0 }

1;
