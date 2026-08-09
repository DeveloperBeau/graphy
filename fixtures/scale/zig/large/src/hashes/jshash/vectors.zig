// smoke-checks jshashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const jshash_sample = "jshash-sample-bytes";

pub fn jshashVerify() bool {
    const d1 = algo.jshashDigest(jshash_sample);
    const d2 = algo.jshashDigest(jshash_sample);
    return d1 == d2 and d1 != 0;
}
