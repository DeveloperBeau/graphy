// times a single fasthashDigest run over the shared sample buffer
const std = @import("std");
const algo = @import("algo.zig");
const timer_mod = @import("../../core/timer.zig");
const sample_mod = @import("../../core/sample.zig");

pub fn fasthashBenchRun() u64 {
    var sw = timer_mod.coreTimerStart();
    const data = sample_mod.coreSampleBytes(256);
    const digest = algo.fasthashDigest(data);
    _ = timer_mod.coreTimerElapsedNanos(&sw);
    return digest;
}
