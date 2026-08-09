// drains a queue of jobs against the simulated clock
const std = @import("std");
const clock_mod = @import("clock.zig");
const queue_mod = @import("queue.zig");
const event_mod = @import("event.zig");
const stats_mod = @import("stats.zig");

pub const LoopResult = struct {
    completed: u32,
    final_tick: u64,
};

pub fn eventloopRun(q: *queue_mod.Queue, clock: *clock_mod.Clock) LoopResult {
    var completed: u32 = 0;
    while (queue_mod.queuePop(q)) |j| {
        _ = event_mod.eventNew(j.id, .Started, clock_mod.clockNow(clock));
        clock_mod.clockAdvance(clock, j.duration_ticks);
        _ = event_mod.eventNew(j.id, .Finished, clock_mod.clockNow(clock));
        stats_mod.statsRecordDuration(j.duration_ticks);
        completed += 1;
    }
    return LoopResult{ .completed = completed, .final_tick = clock_mod.clockNow(clock) };
}
