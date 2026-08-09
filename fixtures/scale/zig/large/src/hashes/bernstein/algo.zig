// bernstein: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn bernsteinDigest(data: []const u8) u64 {
    var h: u64 = 0x1045384558a;
    for (data) |b| {
        h = h *% 0x100043a +% @as(u64, b);
    }
    return h;
}

pub fn bernsteinDigestText(text: []const u8) u64 {
    return bernsteinDigest(text);
}
