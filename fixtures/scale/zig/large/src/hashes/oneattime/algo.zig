// oneattime: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn oneattimeDigest(data: []const u8) u64 {
    var h: u64 = 0x10a81af1674;
    for (data) |b| {
        h = (h << 5) +% h ^ @as(u64, b);
        h ^= 0x1000804;
    }
    return h;
}

pub fn oneattimeDigestText(text: []const u8) u64 {
    return oneattimeDigest(text);
}
