// orchestrates one adler32lite benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn adler32liteRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.adler32liteDigest(data);
    const ok = vectors.adler32liteVerify();
    _ = bench.adler32liteBenchRun();
    return entry_mod.benchEntryNew("adler32lite", digest, ok);
}
