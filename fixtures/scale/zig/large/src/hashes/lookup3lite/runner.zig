// orchestrates one lookup3lite benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn lookup3liteRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.lookup3liteDigest(data);
    const ok = vectors.lookup3liteVerify();
    _ = bench.lookup3liteBenchRun();
    return entry_mod.benchEntryNew("lookup3lite", digest, ok);
}
