// builds a ready-to-schedule batch job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const batch_job = @import("job.zig");

pub fn batchJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = batch_job.batchJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
