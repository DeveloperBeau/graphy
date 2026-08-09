// larsonhash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn larsonhashDigest(data: []const u8) u64 {
    var h: u64 = 0x106cc623c4e;
    for (data) |b| {
        h = h *% 0x10005be +% @as(u64, b);
    }
    return h;
}

pub fn larsonhashDigestText(text: []const u8) u64 {
    return larsonhashDigest(text);
}
