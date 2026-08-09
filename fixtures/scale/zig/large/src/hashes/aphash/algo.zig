// aphash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn aphashDigest(data: []const u8) u64 {
    var h: u64 = 0x1062e2ac29d;
    for (data) |b| {
        h = h *% 0x100055d +% @as(u64, b);
    }
    return h;
}

pub fn aphashDigestText(text: []const u8) u64 {
    return aphashDigest(text);
}
