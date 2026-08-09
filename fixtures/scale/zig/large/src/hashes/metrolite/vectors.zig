// smoke-checks metroliteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const metrolite_sample = "metrolite-sample-bytes";

pub fn metroliteVerify() bool {
    const d1 = algo.metroliteDigest(metrolite_sample);
    const d2 = algo.metroliteDigest(metrolite_sample);
    return d1 == d2 and d1 != 0;
}
