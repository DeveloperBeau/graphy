// feature: struct, enum, union, const
const std = @import("std");

pub const MAX_RETRIES: u32 = 3;
pub const SERVICE_NAME = "graphy-zig-fixture";

pub const State = enum {
    Idle,
    Running,
    Done,
};

pub const Point = struct {
    x: f64,
    y: f64,

    pub fn distance(self: Point) f64 {
        return std.math.sqrt(self.x * self.x + self.y * self.y);
    }
};

pub const Value = union {
    int_val: i64,
    float_val: f64,
};
