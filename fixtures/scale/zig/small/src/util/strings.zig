// small string helpers shared across the config pipeline
const std = @import("std");

pub fn stringsTrim(input: []const u8) []const u8 {
    return std.mem.trim(u8, input, " \t\r\n");
}

pub fn stringsSplitOnce(input: []const u8, sep: u8) ?[2][]const u8 {
    const idx = std.mem.indexOfScalar(u8, input, sep) orelse return null;
    return .{ input[0..idx], input[idx + 1 ..] };
}

pub fn stringsIsBlank(input: []const u8) bool {
    return stringsTrim(input).len == 0;
}
