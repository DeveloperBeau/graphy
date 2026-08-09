// monotonically increasing job identifiers
const std = @import("std");

pub const JobId = u32;

var next_id: JobId = 1;

pub fn idNext() JobId {
    const current = next_id;
    next_id += 1;
    return current;
}

pub fn idReset() void {
    next_id = 1;
}
