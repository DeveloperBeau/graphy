// orchestrates one crc8lite benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn crc8liteRunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.crc8liteDigest(data);
    const ok = vectors.crc8liteVerify();
    _ = bench.crc8liteBenchRun();
    return entry_mod.benchEntryNew("crc8lite", digest, ok);
}
