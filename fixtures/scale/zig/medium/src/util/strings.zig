// tiny string helpers reused by the CLI layer
const std = @import("std");

pub fn stringsTrim(input: []const u8) []const u8 {
    return std.mem.trim(u8, input, " \t\r\n");
}

pub fn stringsEqualsIgnoreCase(a: []const u8, b: []const u8) bool {
    return std.ascii.eqlIgnoreCase(a, b);
}
