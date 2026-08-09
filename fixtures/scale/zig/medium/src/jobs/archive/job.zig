// archive job: behavior specific to the archive workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn archiveJobRun(j: job_mod.Job) u32 {
    std.debug.print("running archive job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn archiveJobLabel() []const u8 {
    return "archive";
}
