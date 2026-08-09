// orchestrates one crc32lite benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn crc32liteRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.crc32liteDigest(data);
    const ok = vectors.crc32liteVerify();
    _ = bench.crc32liteBenchRun();
    return entry_mod.benchEntryNew("crc32lite", digest, ok);
}
