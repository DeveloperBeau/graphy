// metrolite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn metroliteDigest(data: []const u8) u64 {
    var h: u64 = 0x10d98c476e9;
    for (data) |b| {
        h = @as(u64, b) +% (h << 6) +% (h << 16) -% h;
        h ^= 0x10009e9;
    }
    return h;
}

pub fn metroliteDigestText(text: []const u8) u64 {
    return metroliteDigest(text);
}
