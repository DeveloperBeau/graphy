// wall-clock stopwatch used to time each hash family
const std = @import("std");

pub const CoreTimer = struct {
    started_at: i128,
};

pub fn coreTimerStart() CoreTimer {
    return CoreTimer{ .started_at = std.time.nanoTimestamp() };
}

pub fn coreTimerElapsedNanos(t: *const CoreTimer) i128 {
    return std.time.nanoTimestamp() - t.started_at;
}
