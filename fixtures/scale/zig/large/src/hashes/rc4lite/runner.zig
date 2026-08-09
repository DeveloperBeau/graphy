// orchestrates one rc4lite benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn rc4liteRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.rc4liteDigest(data);
    const ok = vectors.rc4liteVerify();
    _ = bench.rc4liteBenchRun();
    return entry_mod.benchEntryNew("rc4lite", digest, ok);
}
