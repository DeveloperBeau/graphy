// builds a ready-to-schedule notify job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const notify_job = @import("job.zig");

pub fn notifyJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = notify_job.notifyJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
