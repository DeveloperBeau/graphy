// smoke-checks farmhashliteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const farmhashlite_sample = "farmhashlite-sample-bytes";

pub fn farmhashliteVerify() bool {
    const d1 = algo.farmhashliteDigest(farmhashlite_sample);
    const d2 = algo.farmhashliteDigest(farmhashlite_sample);
    return d1 == d2 and d1 != 0;
}
