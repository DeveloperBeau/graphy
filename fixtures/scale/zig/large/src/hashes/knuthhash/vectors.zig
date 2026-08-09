// smoke-checks knuthhashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const knuthhash_sample = "knuthhash-sample-bytes";

pub fn knuthhashVerify() bool {
    const d1 = algo.knuthhashDigest(knuthhash_sample);
    const d2 = algo.knuthhashDigest(knuthhash_sample);
    return d1 == d2 and d1 != 0;
}
