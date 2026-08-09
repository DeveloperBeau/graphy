// builds a ready-to-schedule archive job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const archive_job = @import("job.zig");

pub fn archiveJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = archive_job.archiveJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
