// builds a ready-to-schedule io job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const io_job = @import("job.zig");

pub fn ioJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = io_job.ioJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
