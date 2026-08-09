// smoke-checks bkdrhashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const bkdrhash_sample = "bkdrhash-sample-bytes";

pub fn bkdrhashVerify() bool {
    const d1 = algo.bkdrhashDigest(bkdrhash_sample);
    const d2 = algo.bkdrhashDigest(bkdrhash_sample);
    return d1 == d2 and d1 != 0;
}
