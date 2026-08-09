// command-line option parsing
const std = @import("std");

pub const Options = struct {
    path: []const u8,
    verbose: bool,
};

pub fn cliArgsParse(args: []const []const u8) Options {
    var path: []const u8 = "config.txt";
    var verbose = false;
    for (args) |arg| {
        if (std.mem.eql(u8, arg, "-v")) {
            verbose = true;
        } else {
            path = arg;
        }
    }
    return Options{ .path = path, .verbose = verbose };
}
