// builds a ready-to-schedule migrate job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const migrate_job = @import("job.zig");

pub fn migrateJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = migrate_job.migrateJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
