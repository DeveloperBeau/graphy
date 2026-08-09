// network job: behavior specific to the network workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn networkJobRun(j: job_mod.Job) u32 {
    std.debug.print("running network job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn networkJobLabel() []const u8 {
    return "network";
}
