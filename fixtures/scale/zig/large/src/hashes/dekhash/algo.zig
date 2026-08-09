// dekhash: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn dekhashDigest(data: []const u8) u64 {
    var h: u64 = 0x109e3779cc3;
    for (data) |b| {
        h = (h << 5) +% h ^ @as(u64, b);
        h ^= 0x10007a3;
    }
    return h;
}

pub fn dekhashDigestText(text: []const u8) u64 {
    return dekhashDigest(text);
}
