// checksumxor8: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn checksumxor8Digest(data: []const u8) u64 {
    var h: u64 = 0x115a195a4e6;
    var acc: u64 = 0x1000ed6;
    for (data) |b| {
        acc +%= @as(u64, b);
        h ^= acc;
        h = std.math.rotl(u64, h, 7);
    }
    return h;
}

pub fn checksumxor8DigestText(text: []const u8) u64 {
    return checksumxor8Digest(text);
}
