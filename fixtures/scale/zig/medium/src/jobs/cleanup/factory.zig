// builds a ready-to-schedule cleanup job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const cleanup_job = @import("job.zig");

pub fn cleanupJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = cleanup_job.cleanupJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
