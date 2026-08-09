// smoke-checks pearsonDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const pearson_sample = "pearson-sample-bytes";

pub fn pearsonVerify() bool {
    const d1 = algo.pearsonDigest(pearson_sample);
    const d2 = algo.pearsonDigest(pearson_sample);
    return d1 == d2 and d1 != 0;
}
