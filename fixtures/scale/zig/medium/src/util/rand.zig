// deterministic pseudo-random source used to seed job durations
const std = @import("std");

pub const RandState = struct {
    state: u32,
};

pub fn randInit(seed: u32) RandState {
    return RandState{ .state = if (seed == 0) 0x9e3779b9 else seed };
}

pub fn randNext(r: *RandState) u32 {
    var x = r.state;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    r.state = x;
    return x;
}
