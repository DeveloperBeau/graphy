// the simulated tick counter driving the event loop
const std = @import("std");

pub const Clock = struct {
    tick: u64,
};

pub fn clockInit() Clock {
    return Clock{ .tick = 0 };
}

pub fn clockAdvance(c: *Clock, ticks: u32) void {
    c.tick += ticks;
}

pub fn clockNow(c: *const Clock) u64 {
    return c.tick;
}
