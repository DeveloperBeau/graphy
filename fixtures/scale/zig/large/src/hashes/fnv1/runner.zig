// orchestrates one fnv1 benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn fnv1RunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.fnv1Digest(data);
    const ok = vectors.fnv1Verify();
    _ = bench.fnv1BenchRun();
    return entry_mod.benchEntryNew("fnv1", digest, ok);
}
