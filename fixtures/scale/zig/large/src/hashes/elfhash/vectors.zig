// smoke-checks elfhashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const elfhash_sample = "elfhash-sample-bytes";

pub fn elfhashVerify() bool {
    const d1 = algo.elfhashDigest(elfhash_sample);
    const d2 = algo.elfhashDigest(elfhash_sample);
    return d1 == d2 and d1 != 0;
}
