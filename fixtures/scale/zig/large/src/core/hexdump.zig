// hex rendering helpers used when printing digests
const std = @import("std");

pub fn hexdumpEncodeByte(b: u8, out: *[2]u8) void {
    const digits = "0123456789abcdef";
    out[0] = digits[b >> 4];
    out[1] = digits[b & 0x0F];
}

pub fn hexdumpFold(v: u64) u32 {
    return @truncate(v ^ (v >> 32));
}
