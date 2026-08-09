// orchestrates one jenkinslookup2 benchmark entry for the registry
const std = @import("std");
const algo = @import("algo.zig");
const vectors = @import("vectors.zig");
const bench = @import("bench.zig");
const sample_mod = @import("../../core/sample.zig");
const entry_mod = @import("../../bench/entry.zig");

pub fn jenkinslookup2RunnerExecute() entry_mod.BenchEntry {
    const data = sample_mod.coreSampleBytes(64);
    const digest = algo.jenkinslookup2Digest(data);
    const ok = vectors.jenkinslookup2Verify();
    _ = bench.jenkinslookup2BenchRun();
    return entry_mod.benchEntryNew("jenkinslookup2", digest, ok);
}
