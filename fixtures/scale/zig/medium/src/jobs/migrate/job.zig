// migrate job: behavior specific to the migrate workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn migrateJobRun(j: job_mod.Job) u32 {
    std.debug.print("running migrate job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn migrateJobLabel() []const u8 {
    return "migrate";
}
