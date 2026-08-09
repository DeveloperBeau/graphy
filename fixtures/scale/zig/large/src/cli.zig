// thin CLI wrapper around the full benchmark run
const std = @import("std");
const runner_mod = @import("bench/runner.zig");

pub fn cliRun() void {
    runner_mod.benchRunnerExecuteAll();
    std.debug.print("hashbench-zig complete\n", .{});
}
