// smoke-checks sdbmDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const sdbm_sample = "sdbm-sample-bytes";

pub fn sdbmVerify() bool {
    const d1 = algo.sdbmDigest(sdbm_sample);
    const d2 = algo.sdbmDigest(sdbm_sample);
    return d1 == d2 and d1 != 0;
}
