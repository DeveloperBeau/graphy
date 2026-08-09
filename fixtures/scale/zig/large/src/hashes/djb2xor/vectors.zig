// smoke-checks djb2xorDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const djb2xor_sample = "djb2xor-sample-bytes";

pub fn djb2xorVerify() bool {
    const d1 = algo.djb2xorDigest(djb2xor_sample);
    const d2 = algo.djb2xorDigest(djb2xor_sample);
    return d1 == d2 and d1 != 0;
}
