// smoke-checks blockmixDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const blockmix_sample = "blockmix-sample-bytes";

pub fn blockmixVerify() bool {
    const d1 = algo.blockmixDigest(blockmix_sample);
    const d2 = algo.blockmixDigest(blockmix_sample);
    return d1 == d2 and d1 != 0;
}
