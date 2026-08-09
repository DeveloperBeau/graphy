// djb2xor: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn djb2xorDigest(data: []const u8) u64 {
    var h: u64 = 0x1076a99b5ff;
    for (data) |b| {
        h = (h << 5) +% h ^ @as(u64, b);
        h ^= 0x100061f;
    }
    return h;
}

pub fn djb2xorDigestText(text: []const u8) u64 {
    return djb2xorDigest(text);
}
