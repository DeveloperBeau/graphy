// builds a ready-to-schedule network job with sensible defaults
const std = @import("std");
const job_mod = @import("../../core/job.zig");
const network_job = @import("job.zig");

pub fn networkJobCreate(name: []const u8, priority: u8) job_mod.Job {
    const label = network_job.networkJobLabel();
    _ = label;
    return job_mod.jobNew(name, priority, 100);
}
