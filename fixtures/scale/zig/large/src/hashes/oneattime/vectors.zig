// smoke-checks oneattimeDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const oneattime_sample = "oneattime-sample-bytes";

pub fn oneattimeVerify() bool {
    const d1 = algo.oneattimeDigest(oneattime_sample);
    const d2 = algo.oneattimeDigest(oneattime_sample);
    return d1 == d2 and d1 != 0;
}
