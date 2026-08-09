// smoke-checks mixfnvDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const mixfnv_sample = "mixfnv-sample-bytes";

pub fn mixfnvVerify() bool {
    const d1 = algo.mixfnvDigest(mixfnv_sample);
    const d2 = algo.mixfnvDigest(mixfnv_sample);
    return d1 == d2 and d1 != 0;
}
