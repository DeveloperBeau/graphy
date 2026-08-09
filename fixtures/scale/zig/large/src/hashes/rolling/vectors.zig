// smoke-checks rollingDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const rolling_sample = "rolling-sample-bytes";

pub fn rollingVerify() bool {
    const d1 = algo.rollingDigest(rolling_sample);
    const d2 = algo.rollingDigest(rolling_sample);
    return d1 == d2 and d1 != 0;
}
