// orchestrates one xorshiftmix benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn xorshiftmixRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.xorshiftmixDigest(data);
    const ok = vectors.xorshiftmixVerify();
    _ = bench.xorshiftmixBenchRun();
    return entry_mod.benchEntryNew("xorshiftmix", digest, ok);
}
