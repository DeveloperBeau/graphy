// smoke-checks checksumxor8Digest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const checksumxor8_sample = "checksumxor8-sample-bytes";

pub fn checksumxor8Verify() bool {
    const d1 = algo.checksumxor8Digest(checksumxor8_sample);
    const d2 = algo.checksumxor8Digest(checksumxor8_sample);
    return d1 == d2 and d1 != 0;
}
