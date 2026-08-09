// orchestrates one djb2xor benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn djb2xorRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.djb2xorDigest(data);
    const ok = vectors.djb2xorVerify();
    _ = bench.djb2xorBenchRun();
    return entry_mod.benchEntryNew("djb2xor", digest, ok);
}
