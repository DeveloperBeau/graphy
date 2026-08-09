// fnv1a: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn fnv1aDigest(data: []const u8) u64 {
    var h: u64 = 0x100000001b3;
    for (data) |b| {
        h ^= @as(u64, b);
        h = h *% 0x1000193;
        h ^= h >> 33;
    }
    return h;
}

pub fn fnv1aDigestText(text: []const u8) u64 {
    return fnv1aDigest(text);
}
