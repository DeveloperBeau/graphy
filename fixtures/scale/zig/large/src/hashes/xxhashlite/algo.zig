// xxhashlite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn xxhashliteDigest(data: []const u8) u64 {
    var h: u64 = 0x10cfa8cfd38;
    for (data) |b| {
        h = @as(u64, b) +% (h << 6) +% (h << 16) -% h;
        h ^= 0x1000988;
    }
    return h;
}

pub fn xxhashliteDigestText(text: []const u8) u64 {
    return xxhashliteDigest(text);
}
