// avalanche: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn avalancheDigest(data: []const u8) u64 {
    var h: u64 = 0x111ec48cac0;
    for (data) |b| {
        h +%= @as(u64, b);
        h +%= h << 10;
        h ^= h >> 6;
    }
    h +%= h << 3;
    h ^= h >> 11;
    h +%= h << 15;
    h ^= 0x1000c90;
    return h;
}

pub fn avalancheDigestText(text: []const u8) u64 {
    return avalancheDigest(text);
}
