// notify job: behavior specific to the notify workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn notifyJobRun(j: job_mod.Job) u32 {
    std.debug.print("running notify job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn notifyJobLabel() []const u8 {
    return "notify";
}
