// smoke-checks crc8liteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const crc8lite_sample = "crc8lite-sample-bytes";

pub fn crc8liteVerify() bool {
    const d1 = algo.crc8liteDigest(crc8lite_sample);
    const d2 = algo.crc8liteDigest(crc8lite_sample);
    return d1 == d2 and d1 != 0;
}
