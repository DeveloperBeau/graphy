// smoke-checks crc16liteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const crc16lite_sample = "crc16lite-sample-bytes";

pub fn crc16liteVerify() bool {
    const d1 = algo.crc16liteDigest(crc16lite_sample);
    const d2 = algo.crc16liteDigest(crc16lite_sample);
    return d1 == d2 and d1 != 0;
}
