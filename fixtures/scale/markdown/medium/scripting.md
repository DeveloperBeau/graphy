# Scripting abacus

Any file passed on the command line is evaluated line by line before the
prompt appears, so a startup script can define a personal toolkit.

## Defining functions

    fn hyp(a, b) = sqrt(a^2 + b^2)

Definitions may reference earlier ones and any register from
[memory registers](memory.md).

## Batch mode

With `--batch` abacus exits after the script instead of prompting,
printing only the final result. Exit codes are listed in
[troubleshooting](troubleshooting.md).
