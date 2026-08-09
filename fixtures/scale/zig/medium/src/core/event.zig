// events emitted as jobs move through the simulation
const std = @import("std");
const id_mod = @import("id.zig");

pub const EventKind = enum {
    Enqueued,
    Started,
    Finished,
};

pub const Event = struct {
    job_id: id_mod.JobId,
    kind: EventKind,
    at_tick: u64,
};

pub fn eventNew(job_id: id_mod.JobId, kind: EventKind, at_tick: u64) Event {
    return Event{ .job_id = job_id, .kind = kind, .at_tick = at_tick };
}
