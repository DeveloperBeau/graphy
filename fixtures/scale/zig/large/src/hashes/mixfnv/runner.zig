// orchestrates one mixfnv benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn mixfnvRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.mixfnvDigest(data);
    const ok = vectors.mixfnvVerify();
    _ = bench.mixfnvBenchRun();
    return entry_mod.benchEntryNew("mixfnv", digest, ok);
}
