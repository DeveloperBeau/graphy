// crc32lite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn crc32liteDigest(data: []const u8) u64 {
    var h: u64 = 0x11328b7be22;
    var acc: u64 = 0x1000d52;
    for (data) |b| {
        acc +%= @as(u64, b);
        h ^= acc;
        h = std.math.rotl(u64, h, 7);
    }
    return h;
}

pub fn crc32liteDigestText(text: []const u8) u64 {
    return crc32liteDigest(text);
}
