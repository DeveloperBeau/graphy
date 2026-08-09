// smoke-checks teahashDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const teahash_sample = "teahash-sample-bytes";

pub fn teahashVerify() bool {
    const d1 = algo.teahashDigest(teahash_sample);
    const d2 = algo.teahashDigest(teahash_sample);
    return d1 == d2 and d1 != 0;
}
