// entry point for the config-file parser CLI
const std = @import("std");
const args_mod = @import("cli/args.zig");
const commands = @import("cli/commands.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const raw_args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, raw_args);

    const options = args_mod.cliArgsParse(raw_args[1..]);
    try commands.cliCommandsRun(allocator, options);
}
