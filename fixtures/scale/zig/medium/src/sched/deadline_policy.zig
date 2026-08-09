// favors jobs with the shortest remaining duration
const std = @import("std");
const job_mod = @import("../core/job.zig");

pub fn deadlinePolicyRank(j: job_mod.Job) u8 {
    if (j.duration_ticks > 250) return 1;
    return 9;
}
