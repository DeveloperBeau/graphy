// rolling: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn rollingDigest(data: []const u8) u64 {
    var h: u64 = 0x11a9351726e;
    for (data) |b| {
        h = h *% 0x10011de +% @as(u64, b);
        h ^= h >> 29;
    }
    return h;
}

pub fn rollingDigestText(text: []const u8) u64 {
    return rollingDigest(text);
}
