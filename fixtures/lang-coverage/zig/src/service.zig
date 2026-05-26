// feature: @import (std + local), fn, struct with method, call (local + external)
const std = @import("std");
const helpers = @import("helpers.zig");
const types = @import("types.zig");

pub const Service = struct {
    name: []const u8,
    state: types.State,

    const Self = @This();

    pub fn init(name: []const u8) Self {
        return Self{ .name = name, .state = types.State.Idle };
    }

    pub fn run(self: Self) void {
        const greeting = helpers.format_name(self.name);
        std.debug.print("{s}\n", .{greeting});
        _ = types.MAX_RETRIES;
    }
};

pub fn create_service(name: []const u8) Service {
    return Service.init(name);
}
