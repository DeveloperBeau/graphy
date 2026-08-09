// rshash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn rshashDigest(data: []const u8) u64 {
    var h: u64 = 0x108a708a961;
    for (data) |b| {
        h = (h << 5) +% h ^ @as(u64, b);
        h ^= 0x10006e1;
    }
    return h;
}

pub fn rshashDigestText(text: []const u8) u64 {
    return rshashDigest(text);
}
