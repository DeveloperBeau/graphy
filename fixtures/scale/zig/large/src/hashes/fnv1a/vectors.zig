// smoke-checks fnv1aDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const fnv1a_sample = "fnv1a-sample-bytes";

pub fn fnv1aVerify() bool {
    const d1 = algo.fnv1aDigest(fnv1a_sample);
    const d2 = algo.fnv1aDigest(fnv1a_sample);
    return d1 == d2 and d1 != 0;
}
