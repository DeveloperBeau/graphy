// tick-to-duration conversions shared across reporting
const std = @import("std");

pub fn timeTicksToMillis(ticks: u64) u64 {
    return ticks * 4;
}

pub fn timeMillisToTicks(millis: u64) u64 {
    return millis / 4;
}
