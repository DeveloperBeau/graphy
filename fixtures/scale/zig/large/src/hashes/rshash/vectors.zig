// smoke-checks rshashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const rshash_sample = "rshash-sample-bytes";

pub fn rshashVerify() bool {
    const d1 = algo.rshashDigest(rshash_sample);
    const d2 = algo.rshashDigest(rshash_sample);
    return d1 == d2 and d1 != 0;
}
