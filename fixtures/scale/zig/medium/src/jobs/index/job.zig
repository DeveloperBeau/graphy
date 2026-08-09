// index job: behavior specific to the index workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn indexJobRun(j: job_mod.Job) u32 {
    std.debug.print("running index job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn indexJobLabel() []const u8 {
    return "index";
}
