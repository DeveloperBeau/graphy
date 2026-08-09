// rc4lite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn rc4liteDigest(data: []const u8) u64 {
    var h: u64 = 0x11bcfc065d0;
    for (data) |b| {
        h = h *% 0x10012a0 +% @as(u64, b);
        h ^= h >> 29;
    }
    return h;
}

pub fn rc4liteDigestText(text: []const u8) u64 {
    return rc4liteDigest(text);
}
