// cycles a fixed slice budget across jobs regardless of priority
const std = @import("std");
const job_mod = @import("../core/job.zig");

var slice_cursor: u8 = 0;

pub fn roundrobinPolicyRank(j: job_mod.Job) u8 {
    _ = j;
    slice_cursor +%= 1;
    return slice_cursor % 8;
}
