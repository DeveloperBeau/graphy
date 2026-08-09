// spookylite: a small deterministic byte-slice mixing function
const std = @import("std");

pub fn spookyliteDigest(data: []const u8) u64 {
    var h: u64 = 0x10c5c558387;
    for (data) |b| {
        h = @as(u64, b) +% (h << 6) +% (h << 16) -% h;
        h ^= 0x1000927;
    }
    return h;
}

pub fn spookyliteDigestText(text: []const u8) u64 {
    return spookyliteDigest(text);
}
