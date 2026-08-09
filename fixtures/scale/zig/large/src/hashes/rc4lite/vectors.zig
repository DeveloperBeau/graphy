// smoke-checks rc4liteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const rc4lite_sample = "rc4lite-sample-bytes";

pub fn rc4liteVerify() bool {
    const d1 = algo.rc4liteDigest(rc4lite_sample);
    const d2 = algo.rc4liteDigest(rc4lite_sample);
    return d1 == d2 and d1 != 0;
}
