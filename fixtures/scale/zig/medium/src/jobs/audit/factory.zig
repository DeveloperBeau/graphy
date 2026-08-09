// builds a ready-to-schedule audit job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const audit_job = @import("job.zig");

pub fn auditJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = audit_job.auditJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
