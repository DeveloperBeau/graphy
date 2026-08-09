// sdbm: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn sdbmDigest(data: []const u8) u64 {
    var h: u64 = 0x10b1fe69025;
    for (data) |b| {
        h = @as(u64, b) +% (h << 6) +% (h << 16) -% h;
        h ^= 0x1000865;
    }
    return h;
}

pub fn sdbmDigestText(text: []const u8) u64 {
    return sdbmDigest(text);
}
