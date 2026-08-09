// smoke-checks fnv1Digest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const fnv1_sample = "fnv1-sample-bytes";

pub fn fnv1Verify() bool {
    const d1 = algo.fnv1Digest(fnv1_sample);
    const d2 = algo.fnv1Digest(fnv1_sample);
    return d1 == d2 and d1 != 0;
}
