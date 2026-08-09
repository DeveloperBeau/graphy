// smoke-checks goldenhashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const goldenhash_sample = "goldenhash-sample-bytes";

pub fn goldenhashVerify() bool {
    const d1 = algo.goldenhashDigest(goldenhash_sample);
    const d2 = algo.goldenhashDigest(goldenhash_sample);
    return d1 == d2 and d1 != 0;
}
