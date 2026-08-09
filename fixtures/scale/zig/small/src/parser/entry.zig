// a single resolved key/value pair from the config file
const std = @import("std");
const lexer = @import("lexer.zig");
const strings = @import("../util/strings.zig");

pub const Entry = struct {
    key: []const u8,
    value: []const u8,
};

pub fn entryFromToken(tok: lexer.Token) Entry {
    return Entry{ .key = strings.stringsTrim(tok.key), .value = strings.stringsTrim(tok.value) };
}

pub fn entryIsEmpty(e: Entry) bool {
    return e.key.len == 0;
}
