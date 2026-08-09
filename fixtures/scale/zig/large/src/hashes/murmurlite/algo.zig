// murmurlite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn murmurliteDigest(data: []const u8) u64 {
    var h: u64 = 0x1013c6ef515;
    for (data) |b| {
        h ^= @as(u64, b);
        h = h *% 0x1000255;
        h ^= h >> 33;
    }
    return h;
}

pub fn murmurliteDigestText(text: []const u8) u64 {
    return murmurliteDigest(text);
}
