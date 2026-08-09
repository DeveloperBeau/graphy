// smoke-checks wanghashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const wanghash_sample = "wanghash-sample-bytes";

pub fn wanghashVerify() bool {
    const d1 = algo.wanghashDigest(wanghash_sample);
    const d2 = algo.wanghashDigest(wanghash_sample);
    return d1 == d2 and d1 != 0;
}
