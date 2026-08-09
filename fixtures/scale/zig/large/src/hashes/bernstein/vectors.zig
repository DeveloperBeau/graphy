// smoke-checks bernsteinDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const bernstein_sample = "bernstein-sample-bytes";

pub fn bernsteinVerify() bool {
    const d1 = algo.bernsteinDigest(bernstein_sample);
    const d2 = algo.bernsteinDigest(bernstein_sample);
    return d1 == d2 and d1 != 0;
}
