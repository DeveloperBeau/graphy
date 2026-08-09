// elfhash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn elfhashDigest(data: []const u8) u64 {
    var h: u64 = 0x104f1bbcf3b;
    for (data) |b| {
        h = h *% 0x100049b +% @as(u64, b);
    }
    return h;
}

pub fn elfhashDigestText(text: []const u8) u64 {
    return elfhashDigest(text);
}
