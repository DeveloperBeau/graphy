// renders a short summary once the simulation has drained
const std = @import("std");
const stats_mod = @import("../core/stats.zig");
const eventloop_mod = @import("../core/eventloop.zig");

pub fn reportPrintSummary(result: eventloop_mod.LoopResult) void {
    std.debug.print("completed {d} jobs by tick {d}\n", .{ result.completed, result.final_tick });
    std.debug.print("average duration: {d} ticks\n", .{stats_mod.statsAverageDuration()});
}
