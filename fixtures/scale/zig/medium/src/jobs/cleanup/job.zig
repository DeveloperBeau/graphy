// cleanup job: behavior specific to the cleanup workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn cleanupJobRun(j: job_mod.Job) u32 {
    std.debug.print("running cleanup job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn cleanupJobLabel() []const u8 {
    return "cleanup";
}
