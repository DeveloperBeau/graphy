// individual checks applied to parsed config entries
const std = @import("std");
const entry = @import("../parser/entry.zig");
const errors = @import("errors.zig");

pub fn rulesCheckRequired(entries: []const entry.Entry, key: []const u8) ?errors.ValidationError {
    for (entries) |e| {
        if (std.mem.eql(u8, e.key, key)) return null;
    }
    return errors.ValidationError.MissingKey;
}

pub fn rulesCheckNonEmpty(e: entry.Entry) ?errors.ValidationError {
    if (e.value.len == 0) return errors.ValidationError.EmptyValue;
    return null;
}
