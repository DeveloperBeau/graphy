// report job: behavior specific to the report workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn reportJobRun(j: job_mod.Job) u32 {
    std.debug.print("running report job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn reportJobLabel() []const u8 {
    return "report";
}
