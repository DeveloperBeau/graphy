// smoke-checks lookup3liteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const lookup3lite_sample = "lookup3lite-sample-bytes";

pub fn lookup3liteVerify() bool {
    const d1 = algo.lookup3liteDigest(lookup3lite_sample);
    const d2 = algo.lookup3liteDigest(lookup3lite_sample);
    return d1 == d2 and d1 != 0;
}
