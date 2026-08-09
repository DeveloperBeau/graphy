// builds a ready-to-schedule sync job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const sync_job = @import("job.zig");

pub fn syncJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = sync_job.syncJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
