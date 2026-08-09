// compute job: behavior specific to the compute workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn computeJobRun(j: job_mod.Job) u32 {
    std.debug.print("running compute job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn computeJobLabel() []const u8 {
    return "compute";
}
