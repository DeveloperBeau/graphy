// cityhashlite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn cityhashliteDigest(data: []const u8) u64 {
    var h: u64 = 0x101daa66ec6;
    for (data) |b| {
        h ^= @as(u64, b);
        h = h *% 0x10002b6;
        h ^= h >> 33;
    }
    return h;
}

pub fn cityhashliteDigestText(text: []const u8) u64 {
    return cityhashliteDigest(text);
}
