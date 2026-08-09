// splits a raw config line into a key/value token
const std = @import("std");
const strings = @import("../util/strings.zig");

pub const Token = struct {
    key: []const u8,
    value: []const u8,
};

pub fn lexerTokenizeLine(line: []const u8) ?Token {
    const trimmed = strings.stringsTrim(line);
    if (strings.stringsIsBlank(trimmed) or trimmed[0] == '#') return null;
    const parts = strings.stringsSplitOnce(trimmed, '=') orelse return null;
    return Token{ .key = strings.stringsTrim(parts[0]), .value = strings.stringsTrim(parts[1]) };
}

pub fn lexerIsComment(line: []const u8) bool {
    const trimmed = strings.stringsTrim(line);
    return trimmed.len > 0 and trimmed[0] == '#';
}
