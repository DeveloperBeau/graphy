// xorshift32 generator used where a family needs extra entropy
const std = @import("std");

pub const CoreRng = struct {
    state: u32,
};

pub fn coreRngInit(seed: u32) CoreRng {
    return CoreRng{ .state = if (seed == 0) 0xdeadbeef else seed };
}

pub fn coreRngNext(r: *CoreRng) u32 {
    var x = r.state;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    r.state = x;
    return x;
}
