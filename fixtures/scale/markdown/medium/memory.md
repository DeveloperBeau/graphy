# Memory registers

Ten registers, `m0` through `m9`, survive between sessions. Store with
`m3 = ans` and recall by using the register name in any expression.

## Clearing registers

`clear m3` empties one register; `clear memory` empties all ten. The
registers file lives beside the history tape, whose location is given in
[the history tape](history.md).

## Registers versus variables

Variables vanish when abacus exits; registers do not. Anything worth
keeping across sessions belongs in a register or in a script, as
described in [scripting abacus](scripting.md).
