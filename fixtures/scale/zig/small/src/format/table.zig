// two-column table rendering used by the printer
const std = @import("std");
const strings = @import("../util/strings.zig");

pub fn tableRenderRow(key: []const u8, value: []const u8) void {
    const padded_key = strings.stringsTrim(key);
    std.debug.print("{s: <20} | {s}\n", .{ padded_key, value });
}

pub fn tableRenderHeader() void {
    std.debug.print("{s: <20} | {s}\n", .{ "KEY", "VALUE" });
}
