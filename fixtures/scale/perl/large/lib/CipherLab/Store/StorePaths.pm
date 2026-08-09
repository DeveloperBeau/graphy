package CipherLab::Store::StorePaths;
use strict;
use warnings;
use Cwd qw(getcwd);
use File::Path qw(make_path);

sub store_dir     { return getcwd() . '/.cipherlab' }
sub results_file  { return store_dir() . '/results.jsonl' }
sub ensure_dir    { make_path(store_dir()) unless -d store_dir() }

1;
