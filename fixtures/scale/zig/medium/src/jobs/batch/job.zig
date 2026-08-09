// batch job: behavior specific to the batch workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn batchJobRun(j: job_mod.Job) u32 {
    std.debug.print("running batch job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn batchJobLabel() []const u8 {
    return "batch";
}
