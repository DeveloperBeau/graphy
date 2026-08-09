// adler32lite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn adler32liteDigest(data: []const u8) u64 {
    var h: u64 = 0x1128a804471;
    var acc: u64 = 0x1000cf1;
    for (data) |b| {
        acc +%= @as(u64, b);
        h ^= acc;
        h = std.math.rotl(u64, h, 7);
    }
    return h;
}

pub fn adler32liteDigestText(text: []const u8) u64 {
    return adler32liteDigest(text);
}
