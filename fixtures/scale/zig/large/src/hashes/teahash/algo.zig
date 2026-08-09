// teahash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn teahashDigest(data: []const u8) u64 {
    var h: u64 = 0x11b3188ec1f;
    for (data) |b| {
        h = h *% 0x100123f +% @as(u64, b);
        h ^= h >> 29;
    }
    return h;
}

pub fn teahashDigestText(text: []const u8) u64 {
    return teahashDigest(text);
}
