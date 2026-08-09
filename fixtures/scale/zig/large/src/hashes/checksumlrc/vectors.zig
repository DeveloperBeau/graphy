// smoke-checks checksumlrcDigest against a fixed sample
const std = @import("std");
const algo = @import("algo.zig");

pub const checksumlrc_sample = "checksumlrc-sample-bytes";

pub fn checksumlrcVerify() bool {
    const d1 = algo.checksumlrcDigest(checksumlrc_sample);
    const d2 = algo.checksumlrcDigest(checksumlrc_sample);
    return d1 == d2 and d1 != 0;
}
