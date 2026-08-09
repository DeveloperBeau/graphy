// first-in-first-out ordering, priority is ignored
const std = @import("std");
const job_mod = @import("../core/job.zig");

pub fn fifoPolicyRank(j: job_mod.Job) u8 {
    _ = j;
    return 0;
}
