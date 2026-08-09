// fasthash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn fasthashDigest(data: []const u8) u64 {
    var h: u64 = 0x10317156228;
    for (data) |b| {
        h ^= @as(u64, b);
        h = h *% 0x1000378;
        h ^= h >> 33;
    }
    return h;
}

pub fn fasthashDigestText(text: []const u8) u64 {
    return fasthashDigest(text);
}
