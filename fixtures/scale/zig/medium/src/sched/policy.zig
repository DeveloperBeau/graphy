// shared vocabulary for scheduling policies
const std = @import("std");
const job_mod = @import("../core/job.zig");

pub const PolicyKind = enum {
    Fifo,
    Priority,
    RoundRobin,
    Deadline,
};

pub fn policyLabel(kind: PolicyKind) []const u8 {
    return switch (kind) {
        .Fifo => "fifo",
        .Priority => "priority",
        .RoundRobin => "round-robin",
        .Deadline => "deadline",
    };
}
