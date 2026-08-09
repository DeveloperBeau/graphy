// smoke-checks dekhashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const dekhash_sample = "dekhash-sample-bytes";

pub fn dekhashVerify() bool {
    const d1 = algo.dekhashDigest(dekhash_sample);
    const d2 = algo.dekhashDigest(dekhash_sample);
    return d1 == d2 and d1 != 0;
}
