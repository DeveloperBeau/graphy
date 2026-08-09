// checksumsum8: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn checksumsum8Digest(data: []const u8) u64 {
    var h: u64 = 0x115035e2b35;
    var acc: u64 = 0x1000e75;
    for (data) |b| {
        acc +%= @as(u64, b);
        h ^= acc;
        h = std.math.rotl(u64, h, 7);
    }
    return h;
}

pub fn checksumsum8DigestText(text: []const u8) u64 {
    return checksumsum8Digest(text);
}
