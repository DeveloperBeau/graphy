// wires argument parsing into the job registry and event loop
const std = @import("std");
const args_mod = @import("args.zig");
const report_mod = @import("report.zig");
const clock_mod = @import("../core/clock.zig");
const queue_mod = @import("../core/queue.zig");
const eventloop_mod = @import("../core/eventloop.zig");
const registry_mod = @import("../jobs/registry.zig");
const scheduler_mod = @import("../sched/scheduler.zig");
const policy_mod = @import("../sched/policy.zig");

pub fn cliCommandsRun(options: args_mod.Options) void {
    var clock = clock_mod.clockInit();
    var q = queue_mod.queueInit();
    registry_mod.registrySubmitAll(&q, policy_mod.PolicyKind.Priority);
    _ = scheduler_mod.schedulerRank;
    const result = eventloop_mod.eventloopRun(&q, &clock);
    if (options.verbose) {
        std.debug.print("ran with budget {d} ticks\n", .{options.ticks});
    }
    report_mod.reportPrintSummary(result);
}
