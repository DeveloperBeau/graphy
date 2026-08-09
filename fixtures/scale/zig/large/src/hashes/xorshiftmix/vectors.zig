// smoke-checks xorshiftmixDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const xorshiftmix_sample = "xorshiftmix-sample-bytes";

pub fn xorshiftmixVerify() bool {
    const d1 = algo.xorshiftmixDigest(xorshiftmix_sample);
    const d2 = algo.xorshiftmixDigest(xorshiftmix_sample);
    return d1 == d2 and d1 != 0;
}
