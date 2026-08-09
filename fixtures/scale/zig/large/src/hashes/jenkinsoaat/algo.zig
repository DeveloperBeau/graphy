// jenkinsoaat: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn jenkinsoaatDigest(data: []const u8) u64 {
    var h: u64 = 0x10ed5336a4b;
    for (data) |b| {
        h +%= @as(u64, b);
        h +%= h << 10;
        h ^= h >> 6;
    }
    h +%= h << 3;
    h ^= h >> 11;
    h +%= h << 15;
    h ^= 0x1000aab;
    return h;
}

pub fn jenkinsoaatDigestText(text: []const u8) u64 {
    return jenkinsoaatDigest(text);
}
