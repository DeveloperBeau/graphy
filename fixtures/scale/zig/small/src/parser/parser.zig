// reads a config file and turns it into a list of entries
const std = @import("std");
const lexer = @import("lexer.zig");
const entry = @import("entry.zig");
const io = @import("../util/io.zig");

pub const ParseResult = struct {
    entries: [64]entry.Entry,
    count: usize,
};

pub fn parserParseFile(allocator: std.mem.Allocator, path: []const u8) !ParseResult {
    const contents = try io.ioReadFileLines(allocator, path);
    var result = ParseResult{ .entries = undefined, .count = 0 };
    var lines = std.mem.splitScalar(u8, contents, '\n');
    while (lines.next()) |line| {
        const tok = lexer.lexerTokenizeLine(line) orelse continue;
        if (result.count >= result.entries.len) break;
        result.entries[result.count] = entry.entryFromToken(tok);
        result.count += 1;
    }
    return result;
}
