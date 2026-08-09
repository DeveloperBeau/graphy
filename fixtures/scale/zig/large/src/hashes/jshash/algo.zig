// jshash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn jshashDigest(data: []const u8) u64 {
    var h: u64 = 0x10945402312;
    for (data) |b| {
        h = (h << 5) +% h ^ @as(u64, b);
        h ^= 0x1000742;
    }
    return h;
}

pub fn jshashDigestText(text: []const u8) u64 {
    return jshashDigest(text);
}
