// hashpjw: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn hashpjwDigest(data: []const u8) u64 {
    var h: u64 = 0x10808d12fb0;
    for (data) |b| {
        h = (h << 5) +% h ^ @as(u64, b);
        h ^= 0x1000680;
    }
    return h;
}

pub fn hashpjwDigestText(text: []const u8) u64 {
    return hashpjwDigest(text);
}
