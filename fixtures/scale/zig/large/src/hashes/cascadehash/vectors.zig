// smoke-checks cascadehashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const cascadehash_sample = "cascadehash-sample-bytes";

pub fn cascadehashVerify() bool {
    const d1 = algo.cascadehashDigest(cascadehash_sample);
    const d2 = algo.cascadehashDigest(cascadehash_sample);
    return d1 == d2 and d1 != 0;
}
