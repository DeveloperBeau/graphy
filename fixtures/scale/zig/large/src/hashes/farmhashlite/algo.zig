// farmhashlite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn farmhashliteDigest(data: []const u8) u64 {
    var h: u64 = 0x10278dde877;
    for (data) |b| {
        h ^= @as(u64, b);
        h = h *% 0x1000317;
        h ^= h >> 33;
    }
    return h;
}

pub fn farmhashliteDigestText(text: []const u8) u64 {
    return farmhashliteDigest(text);
}
