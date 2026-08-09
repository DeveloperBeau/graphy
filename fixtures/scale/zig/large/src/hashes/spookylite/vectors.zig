// smoke-checks spookyliteDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const spookylite_sample = "spookylite-sample-bytes";

pub fn spookyliteVerify() bool {
    const d1 = algo.spookyliteDigest(spookylite_sample);
    const d2 = algo.spookyliteDigest(spookylite_sample);
    return d1 == d2 and d1 != 0;
}
