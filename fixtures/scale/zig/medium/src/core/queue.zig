// a small fixed-capacity priority queue of jobs
const std = @import("std");
const job_mod = @import("job.zig");

pub const Queue = struct {
    items: [128]job_mod.Job,
    len: usize,
};

pub fn queueInit() Queue {
    return Queue{ .items = undefined, .len = 0 };
}

pub fn queuePush(q: *Queue, j: job_mod.Job) void {
    if (q.len >= q.items.len) return;
    var i = q.len;
    q.items[i] = j;
    q.len += 1;
    while (i > 0 and q.items[i - 1].priority < q.items[i].priority) {
        const tmp = q.items[i - 1];
        q.items[i - 1] = q.items[i];
        q.items[i] = tmp;
        i -= 1;
    }
}

pub fn queuePop(q: *Queue) ?job_mod.Job {
    if (q.len == 0) return null;
    const top = q.items[0];
    var i: usize = 1;
    while (i < q.len) : (i += 1) {
        q.items[i - 1] = q.items[i];
    }
    q.len -= 1;
    return top;
}
