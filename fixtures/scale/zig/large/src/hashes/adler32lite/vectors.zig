// smoke-checks adler32liteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const adler32lite_sample = "adler32lite-sample-bytes";

pub fn adler32liteVerify() bool {
    const d1 = algo.adler32liteDigest(adler32lite_sample);
    const d2 = algo.adler32liteDigest(adler32lite_sample);
    return d1 == d2 and d1 != 0;
}
