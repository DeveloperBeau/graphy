// smoke-checks sumfoldDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const sumfold_sample = "sumfold-sample-bytes";

pub fn sumfoldVerify() bool {
    const d1 = algo.sumfoldDigest(sumfold_sample);
    const d2 = algo.sumfoldDigest(sumfold_sample);
    return d1 == d2 and d1 != 0;
}
