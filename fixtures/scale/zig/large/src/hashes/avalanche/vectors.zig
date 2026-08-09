// smoke-checks avalancheDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const avalanche_sample = "avalanche-sample-bytes";

pub fn avalancheVerify() bool {
    const d1 = algo.avalancheDigest(avalanche_sample);
    const d2 = algo.avalancheDigest(avalanche_sample);
    return d1 == d2 and d1 != 0;
}
