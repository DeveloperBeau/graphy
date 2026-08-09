// smoke-checks siphashliteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const siphashlite_sample = "siphashlite-sample-bytes";

pub fn siphashliteVerify() bool {
    const d1 = algo.siphashliteDigest(siphashlite_sample);
    const d2 = algo.siphashliteDigest(siphashlite_sample);
    return d1 == d2 and d1 != 0;
}
