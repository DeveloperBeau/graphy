// smoke-checks djb2Digest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const djb2_sample = "djb2-sample-bytes";

pub fn djb2Verify() bool {
    const d1 = algo.djb2Digest(djb2_sample);
    const d2 = algo.djb2Digest(djb2_sample);
    return d1 == d2 and d1 != 0;
}
