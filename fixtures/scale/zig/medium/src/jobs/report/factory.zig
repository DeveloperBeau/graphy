// builds a ready-to-schedule report job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const report_job = @import("job.zig");

pub fn reportJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = report_job.reportJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
