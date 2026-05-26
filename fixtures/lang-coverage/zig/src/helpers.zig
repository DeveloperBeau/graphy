// feature: top-level functions, cross-file callee
const std = @import("std");

pub fn format_name(name: []const u8) []const u8 {
    _ = name;
    return "hi";
}

pub fn unrelated_helper() u32 {
    return 7;
}
