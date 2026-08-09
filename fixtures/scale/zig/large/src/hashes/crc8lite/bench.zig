// times a single crc8liteDigest run over the shared sample buffer
const std = @import("std");
const algo = @import("algo.zig");
const timer_mod = @import("../../core/timer.zig");
const sample_mod = @import("../../core/sample.zig");

pub fn crc8liteBenchRun() u64 {
    var sw = timer_mod.coreTimerStart();
    const data = sample_mod.coreSampleBytes(256);
    const digest = algo.crc8liteDigest(data);
    _ = timer_mod.coreTimerElapsedNanos(&sw);
    return digest;
}
