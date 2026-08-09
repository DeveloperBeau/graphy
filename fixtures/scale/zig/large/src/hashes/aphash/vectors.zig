// smoke-checks aphashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const aphash_sample = "aphash-sample-bytes";

pub fn aphashVerify() bool {
    const d1 = algo.aphashDigest(aphash_sample);
    const d2 = algo.aphashDigest(aphash_sample);
    return d1 == d2 and d1 != 0;
}
