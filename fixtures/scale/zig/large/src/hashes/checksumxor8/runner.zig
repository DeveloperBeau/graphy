// orchestrates one checksumxor8 benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn checksumxor8RunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.checksumxor8Digest(data);
    const ok = vectors.checksumxor8Verify();
    _ = bench.checksumxor8BenchRun();
    return entry_mod.benchEntryNew("checksumxor8", digest, ok);
}
