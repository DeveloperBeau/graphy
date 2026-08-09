// deterministic byte samples fed into every hash family under benchmark
const std = @import("std");

const buffer_a: [256]u8 = blk: {
    var buf: [256]u8 = undefined;
    var i: usize = 0;
    while (i < 256) : (i += 1) {
        buf[i] = @intCast((i * 31 + 7) % 256);
    }
    break :blk buf;
};

pub fn coreSampleBytes(len: usize) []const u8 {
    const n = @min(len, buffer_a.len);
    return buffer_a[0..n];
}

pub fn coreSampleText() []const u8 {
    return "the quick brown fox jumps over the lazy dog";
}
