// backup job: behavior specific to the backup workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn backupJobRun(j: job_mod.Job) u32 {
    std.debug.print("running backup job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn backupJobLabel() []const u8 {
    return "backup";
}
