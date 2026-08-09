// orchestrates one fnv1a benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn fnv1aRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.fnv1aDigest(data);
    const ok = vectors.fnv1aVerify();
    _ = bench.fnv1aBenchRun();
    return entry_mod.benchEntryNew("fnv1a", digest, ok);
}
