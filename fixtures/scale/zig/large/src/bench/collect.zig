// aggregates bench entries once every family has run
const std = @import("std");
const entry_mod = @import("entry.zig");

pub fn benchCollectCountOk(entries: []const entry_mod.BenchEntry) usize {
    var n: usize = 0;
    for (entries) |e| {
        if (e.ok) n += 1;
    }
    return n;
}

pub fn benchCollectDigestSum(entries: []const entry_mod.BenchEntry) u64 {
    var total: u64 = 0;
    for (entries) |e| total +%= e.digest;
    return total;
}
