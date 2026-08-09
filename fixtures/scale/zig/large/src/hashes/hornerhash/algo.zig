// hornerhash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn hornerhashDigest(data: []const u8) u64 {
    var h: u64 = 0x119f519f8bd;
    for (data) |b| {
        h = h *% 0x100117d +% @as(u64, b);
        h ^= h >> 29;
    }
    return h;
}

pub fn hornerhashDigestText(text: []const u8) u64 {
    return hornerhashDigest(text);
}
