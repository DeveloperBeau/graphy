// smoke-checks hornerhashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const hornerhash_sample = "hornerhash-sample-bytes";

pub fn hornerhashVerify() bool {
    const d1 = algo.hornerhashDigest(hornerhash_sample);
    const d2 = algo.hornerhashDigest(hornerhash_sample);
    return d1 == d2 and d1 != 0;
}
