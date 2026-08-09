// smoke-checks cityhashliteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const cityhashlite_sample = "cityhashlite-sample-bytes";

pub fn cityhashliteVerify() bool {
    const d1 = algo.cityhashliteDigest(cityhashlite_sample);
    const d2 = algo.cityhashliteDigest(cityhashlite_sample);
    return d1 == d2 and d1 != 0;
}
