// bytesum: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn bytesumDigest(data: []const u8) u64 {
    var h: u64 = 0x11d0c2f5932;
    for (data) |b| {
        h = h *% 0x1001362 +% @as(u64, b);
        h ^= h >> 29;
    }
    return h;
}

pub fn bytesumDigestText(text: []const u8) u64 {
    return bytesumDigest(text);
}
