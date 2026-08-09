// crc8lite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn crc8liteDigest(data: []const u8) u64 {
    var h: u64 = 0x1146526b184;
    var acc: u64 = 0x1000e14;
    for (data) |b| {
        acc +%= @as(u64, b);
        h ^= acc;
        h = std.math.rotl(u64, h, 7);
    }
    return h;
}

pub fn crc8liteDigestText(text: []const u8) u64 {
    return crc8liteDigest(text);
}
