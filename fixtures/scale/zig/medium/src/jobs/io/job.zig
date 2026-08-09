// io job: behavior specific to the io workload
const std = @import("std");
const job_mod = @import("../../core/job.zig");

pub fn ioJobRun(j: job_mod.Job) u32 {
    std.debug.print("running io job {s}\n", .{j.name});
    return j.duration_ticks;
}

pub fn ioJobLabel() []const u8 {
    return "io";
}
