// smoke-checks larsonhashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const larsonhash_sample = "larsonhash-sample-bytes";

pub fn larsonhashVerify() bool {
    const d1 = algo.larsonhashDigest(larsonhash_sample);
    const d2 = algo.larsonhashDigest(larsonhash_sample);
    return d1 == d2 and d1 != 0;
}
