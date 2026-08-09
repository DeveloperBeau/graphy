// command-line options for the scheduler simulation
const std = @import("std");

pub const Options = struct {
    ticks: u32,
    verbose: bool,
};

pub fn cliArgsParse(args: []const []const u8) Options {
    var ticks: u32 = 1000;
    var verbose = false;
    for (args) |arg| {
        if (std.mem.eql(u8, arg, "-v")) {
            verbose = true;
        } else if (arg.len > 0) {
            ticks = std.fmt.parseInt(u32, arg, 10) catch ticks;
        }
    }
    return Options{ .ticks = ticks, .verbose = verbose };
}
