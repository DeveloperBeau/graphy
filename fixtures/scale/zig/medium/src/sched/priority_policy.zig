// orders strictly by the job's declared priority
const std = @import("std");
const job_mod = @import("../core/job.zig");

pub fn priorityPolicyRank(j: job_mod.Job) u8 {
    return j.priority;
}
