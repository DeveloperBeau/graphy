// fnv1: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn fnv1Digest(data: []const u8) u64 {
    var h: u64 = 0x1009e377b64;
    for (data) |b| {
        h ^= @as(u64, b);
        h = h *% 0x10001f4;
        h ^= h >> 33;
    }
    return h;
}

pub fn fnv1DigestText(text: []const u8) u64 {
    return fnv1Digest(text);
}
