// smoke-checks hashpjwDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const hashpjw_sample = "hashpjw-sample-bytes";

pub fn hashpjwVerify() bool {
    const d1 = algo.hashpjwDigest(hashpjw_sample);
    const d2 = algo.hashpjwDigest(hashpjw_sample);
    return d1 == d2 and d1 != 0;
}
