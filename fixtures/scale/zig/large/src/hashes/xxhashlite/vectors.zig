// smoke-checks xxhashliteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const xxhashlite_sample = "xxhashlite-sample-bytes";

pub fn xxhashliteVerify() bool {
    const d1 = algo.xxhashliteDigest(xxhashlite_sample);
    const d2 = algo.xxhashliteDigest(xxhashlite_sample);
    return d1 == d2 and d1 != 0;
}
