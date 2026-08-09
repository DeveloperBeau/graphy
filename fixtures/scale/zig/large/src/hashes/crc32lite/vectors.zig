// smoke-checks crc32liteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const crc32lite_sample = "crc32lite-sample-bytes";

pub fn crc32liteVerify() bool {
    const d1 = algo.crc32liteDigest(crc32lite_sample);
    const d2 = algo.crc32liteDigest(crc32lite_sample);
    return d1 == d2 and d1 != 0;
}
