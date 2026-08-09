// bkdrhash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn bkdrhashDigest(data: []const u8) u64 {
    var h: u64 = 0x1058ff348ec;
    for (data) |b| {
        h = h *% 0x10004fc +% @as(u64, b);
    }
    return h;
}

pub fn bkdrhashDigestText(text: []const u8) u64 {
    return bkdrhashDigest(text);
}
