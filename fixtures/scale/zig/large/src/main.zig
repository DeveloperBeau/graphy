// entry point for the hash-function benchmark suite
const std = @import("std");
const cli_mod = @import("cli.zig");

pub fn main() void {
    cli_mod.cliRun();
}
