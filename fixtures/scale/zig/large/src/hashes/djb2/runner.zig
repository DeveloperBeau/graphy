// orchestrates one djb2 benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn djb2RunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.djb2Digest(data);
    const ok = vectors.djb2Verify();
    _ = bench.djb2BenchRun();
    return entry_mod.benchEntryNew("djb2", digest, ok);
}
