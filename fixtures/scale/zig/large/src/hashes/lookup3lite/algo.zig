// lookup3lite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn lookup3liteDigest(data: []const u8) u64 {
    var h: u64 = 0x10bbe1e09d6;
    for (data) |b| {
        h = @as(u64, b) +% (h << 6) +% (h << 16) -% h;
        h ^= 0x10008c6;
    }
    return h;
}

pub fn lookup3liteDigestText(text: []const u8) u64 {
    return lookup3liteDigest(text);
}
