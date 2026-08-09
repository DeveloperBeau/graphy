// smoke-checks checksumsum8Digest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const checksumsum8_sample = "checksumsum8-sample-bytes";

pub fn checksumsum8Verify() bool {
    const d1 = algo.checksumsum8Digest(checksumsum8_sample);
    const d2 = algo.checksumsum8Digest(checksumsum8_sample);
    return d1 == d2 and d1 != 0;
}
