// smoke-checks fasthashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const fasthash_sample = "fasthash-sample-bytes";

pub fn fasthashVerify() bool {
    const d1 = algo.fasthashDigest(fasthash_sample);
    const d2 = algo.fasthashDigest(fasthash_sample);
    return d1 == d2 and d1 != 0;
}
