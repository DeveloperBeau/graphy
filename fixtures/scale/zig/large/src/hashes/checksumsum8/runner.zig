// orchestrates one checksumsum8 benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn checksumsum8RunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.checksumsum8Digest(data);
    const ok = vectors.checksumsum8Verify();
    _ = bench.checksumsum8BenchRun();
    return entry_mod.benchEntryNew("checksumsum8", digest, ok);
}
