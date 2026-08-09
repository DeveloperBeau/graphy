// builds a ready-to-schedule backup job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const backup_job = @import("job.zig");

pub fn backupJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = backup_job.backupJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
