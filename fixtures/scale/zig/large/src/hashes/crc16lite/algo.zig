// crc16lite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn crc16liteDigest(data: []const u8) u64 {
    var h: u64 = 0x113c6ef37d3;
    var acc: u64 = 0x1000db3;
    for (data) |b| {
        acc +%= @as(u64, b);
        h ^= acc;
        h = std.math.rotl(u64, h, 7);
    }
    return h;
}

pub fn crc16liteDigestText(text: []const u8) u64 {
    return crc16liteDigest(text);
}
