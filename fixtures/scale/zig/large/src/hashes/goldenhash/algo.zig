// goldenhash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn goldenhashDigest(data: []const u8) u64 {
    var h: u64 = 0x1114e11510f;
    for (data) |b| {
        h +%= @as(u64, b);
        h +%= h << 10;
        h ^= h >> 6;
    }
    h +%= h << 3;
    h ^= h >> 11;
    h +%= h << 15;
    h ^= 0x1000c2f;
    return h;
}

pub fn goldenhashDigestText(text: []const u8) u64 {
    return goldenhashDigest(text);
}
