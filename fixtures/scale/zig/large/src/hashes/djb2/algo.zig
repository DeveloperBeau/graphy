// djb2: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn djb2Digest(data: []const u8) u64 {
    var h: u64 = 0x103b54cdbd9;
    for (data) |b| {
        h = h *% 0x10003d9 +% @as(u64, b);
    }
    return h;
}

pub fn djb2DigestText(text: []const u8) u64 {
    return djb2Digest(text);
}
