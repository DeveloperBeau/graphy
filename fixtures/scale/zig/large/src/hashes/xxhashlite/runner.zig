// orchestrates one xxhashlite benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn xxhashliteRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.xxhashliteDigest(data);
    const ok = vectors.xxhashliteVerify();
    _ = bench.xxhashliteBenchRun();
    return entry_mod.benchEntryNew("xxhashlite", digest, ok);
}
