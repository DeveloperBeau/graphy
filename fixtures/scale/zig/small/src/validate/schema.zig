// ties required-key and value rules together into one pass
const std = @import("std");
const entry = @import("../parser/entry.zig");
const rules = @import("rules.zig");
const errors = @import("errors.zig");

pub const Schema = struct {
    required_keys: []const []const u8,
};

pub fn schemaValidate(schema: Schema, entries: []const entry.Entry) usize {
    var problems: usize = 0;
    for (schema.required_keys) |key| {
        if (rules.rulesCheckRequired(entries, key)) |err| {
            std.debug.print("schema error: {s}\n", .{errors.errorsDescribe(err)});
            problems += 1;
        }
    }
    for (entries) |e| {
        if (rules.rulesCheckNonEmpty(e)) |err| {
            std.debug.print("schema error: {s}\n", .{errors.errorsDescribe(err)});
            problems += 1;
        }
    }
    return problems;
}
