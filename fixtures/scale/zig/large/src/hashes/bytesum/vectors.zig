// smoke-checks bytesumDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const bytesum_sample = "bytesum-sample-bytes";

pub fn bytesumVerify() bool {
    const d1 = algo.bytesumDigest(bytesum_sample);
    const d2 = algo.bytesumDigest(bytesum_sample);
    return d1 == d2 and d1 != 0;
}
