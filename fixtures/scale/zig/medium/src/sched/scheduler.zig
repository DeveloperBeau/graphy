// applies a policy to rank jobs before they enter the queue
const std = @import("std");
const job_mod = @import("../core/job.zig");
const queue_mod = @import("../core/queue.zig");
const policy_mod = @import("policy.zig");
const fifo_policy = @import("fifo_policy.zig");
const priority_policy = @import("priority_policy.zig");
const roundrobin_policy = @import("roundrobin_policy.zig");
const deadline_policy = @import("deadline_policy.zig");

pub fn schedulerRank(kind: policy_mod.PolicyKind, j: job_mod.Job) u8 {
    return switch (kind) {
        .Fifo => fifo_policy.fifoPolicyRank(j),
        .Priority => priority_policy.priorityPolicyRank(j),
        .RoundRobin => roundrobin_policy.roundrobinPolicyRank(j),
        .Deadline => deadline_policy.deadlinePolicyRank(j),
    };
}

pub fn schedulerSubmit(q: *queue_mod.Queue, kind: policy_mod.PolicyKind, job: job_mod.Job) void {
    var ranked = job;
    ranked.priority = schedulerRank(kind, job);
    queue_mod.queuePush(q, ranked);
}
