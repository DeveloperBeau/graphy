// smoke-checks jenkinsoaatDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const jenkinsoaat_sample = "jenkinsoaat-sample-bytes";

pub fn jenkinsoaatVerify() bool {
    const d1 = algo.jenkinsoaatDigest(jenkinsoaat_sample);
    const d2 = algo.jenkinsoaatDigest(jenkinsoaat_sample);
    return d1 == d2 and d1 != 0;
}
