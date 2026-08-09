// builds a ready-to-schedule compute job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const compute_job = @import("job.zig");

pub fn computeJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = compute_job.computeJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
