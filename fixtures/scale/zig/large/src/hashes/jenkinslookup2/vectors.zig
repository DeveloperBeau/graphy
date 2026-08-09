// smoke-checks jenkinslookup2Digest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const jenkinslookup2_sample = "jenkinslookup2-sample-bytes";

pub fn jenkinslookup2Verify() bool {
    const d1 = algo.jenkinslookup2Digest(jenkinslookup2_sample);
    const d2 = algo.jenkinslookup2Digest(jenkinslookup2_sample);
    return d1 == d2 and d1 != 0;
}
