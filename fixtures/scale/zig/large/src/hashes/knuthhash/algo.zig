// knuthhash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn knuthhashDigest(data: []const u8) u64 {
    var h: u64 = 0x110afd9d75e;
    for (data) |b| {
        h +%= @as(u64, b);
        h +%= h << 10;
        h ^= h >> 6;
    }
    h +%= h << 3;
    h ^= h >> 11;
    h +%= h << 15;
    h ^= 0x1000bce;
    return h;
}

pub fn knuthhashDigestText(text: []const u8) u64 {
    return knuthhashDigest(text);
}
