// mixfnv: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn mixfnvDigest(data: []const u8) u64 {
    var h: u64 = 0x11c6df7df81;
    for (data) |b| {
        h = h *% 0x1001301 +% @as(u64, b);
        h ^= h >> 29;
    }
    return h;
}

pub fn mixfnvDigestText(text: []const u8) u64 {
    return mixfnvDigest(text);
}
