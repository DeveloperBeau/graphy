// jenkinslookup2: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn jenkinslookup2Digest(data: []const u8) u64 {
    var h: u64 = 0x10f736ae3fc;
    for (data) |b| {
        h +%= @as(u64, b);
        h +%= h << 10;
        h ^= h >> 6;
    }
    h +%= h << 3;
    h ^= h >> 11;
    h +%= h << 15;
    h ^= 0x1000b0c;
    return h;
}

pub fn jenkinslookup2DigestText(text: []const u8) u64 {
    return jenkinslookup2Digest(text);
}
