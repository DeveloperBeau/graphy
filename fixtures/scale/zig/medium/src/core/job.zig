// the unit of work scheduled and run by the simulation
const std = @import("std");
const id_mod = @import("id.zig");

pub const Job = struct {
    id: id_mod.JobId,
    name: []const u8,
    priority: u8,
    duration_ticks: u32,
};

pub fn jobNew(name: []const u8, priority: u8, duration_ticks: u32) Job {
    return Job{
        .id = id_mod.idNext(),
        .name = name,
        .priority = priority,
        .duration_ticks = duration_ticks,
    };
}
