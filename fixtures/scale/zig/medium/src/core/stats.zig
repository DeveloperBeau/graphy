// running totals collected while the event loop drains jobs
const std = @import("std");

var total_duration: u64 = 0;
var job_count: u32 = 0;

pub fn statsRecordDuration(duration_ticks: u32) void {
    total_duration += duration_ticks;
    job_count += 1;
}

pub fn statsAverageDuration() u64 {
    if (job_count == 0) return 0;
    return total_duration / job_count;
}

pub fn statsReset() void {
    total_duration = 0;
    job_count = 0;
}
