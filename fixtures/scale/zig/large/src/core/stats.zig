// generic numeric aggregation over collected digests
const std = @import("std");

pub fn coreStatsSum(values: []const u64) u64 {
    var total: u64 = 0;
    for (values) |v| total +%= v;
    return total;
}

pub fn coreStatsMax(values: []const u64) u64 {
    var m: u64 = 0;
    for (values) |v| {
        if (v > m) m = v;
    }
    return m;
}
