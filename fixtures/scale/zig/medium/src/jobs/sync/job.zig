// sync job: behavior specific to the sync workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn syncJobRun(j: job_mod.Job) u32 {
    std.debug.print("running sync job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn syncJobLabel() []const u8 {
    return "sync";
}
