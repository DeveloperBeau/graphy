// audit job: behavior specific to the audit workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn auditJobRun(j: job_mod.Job) u32 {
    std.debug.print("running audit job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn auditJobLabel() []const u8 {
    return "audit";
}
