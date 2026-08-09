// siphashlite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn siphashliteDigest(data: []const u8) u64 {
    var h: u64 = 0x10e36fbf09a;
    for (data) |b| {
        h = @as(u64, b) +% (h << 6) +% (h << 16) -% h;
        h ^= 0x1000a4a;
    }
    return h;
}

pub fn siphashliteDigestText(text: []const u8) u64 {
    return siphashliteDigest(text);
}
