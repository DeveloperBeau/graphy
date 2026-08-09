// orchestrates one checksumlrc benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn checksumlrcRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.checksumlrcDigest(data);
    const ok = vectors.checksumlrcVerify();
    _ = bench.checksumlrcBenchRun();
    return entry_mod.benchEntryNew("checksumlrc", digest, ok);
}
