// a single benchmarked family's result
const std = @import("std");

pub const BenchEntry = struct {
    name: []const u8,
    digest: u64,
    ok: bool,
};

pub fn benchEntryNew(name: []const u8, digest: u64, ok: bool) BenchEntry {
    return BenchEntry{ .name = name, .digest = digest, .ok = ok };
}
