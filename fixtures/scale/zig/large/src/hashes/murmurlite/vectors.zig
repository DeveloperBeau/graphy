// smoke-checks murmurliteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const murmurlite_sample = "murmurlite-sample-bytes";

pub fn murmurliteVerify() bool {
    const d1 = algo.murmurliteDigest(murmurlite_sample);
    const d2 = algo.murmurliteDigest(murmurlite_sample);
    return d1 == d2 and d1 != 0;
}
