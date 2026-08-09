// builds a ready-to-schedule index job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const index_job = @import("job.zig");

pub fn indexJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = index_job.indexJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
