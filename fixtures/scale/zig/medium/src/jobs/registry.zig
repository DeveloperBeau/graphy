// central registry: submits one job per workload kind into the queue
const std = @import("std");
const job_mod = @import("../core/job.zig");
const queue_mod = @import("../core/queue.zig");
const scheduler_mod = @import("../sched/scheduler.zig");
const policy_mod = @import("../sched/policy.zig");
const compute_factory = @import("compute/factory.zig");
const io_factory = @import("io/factory.zig");
const network_factory = @import("network/factory.zig");
const batch_factory = @import("batch/factory.zig");
const report_factory = @import("report/factory.zig");
const cleanup_factory = @import("cleanup/factory.zig");
const backup_factory = @import("backup/factory.zig");
const notify_factory = @import("notify/factory.zig");
const index_factory = @import("index/factory.zig");
const migrate_factory = @import("migrate/factory.zig");
const archive_factory = @import("archive/factory.zig");
const sync_factory = @import("sync/factory.zig");
const audit_factory = @import("audit/factory.zig");

pub fn registrySubmitAll(q: *queue_mod.Queue, kind: policy_mod.PolicyKind) void {
    scheduler_mod.schedulerSubmit(q, kind, compute_factory.computeJobCreate("compute-0", 1));
    scheduler_mod.schedulerSubmit(q, kind, io_factory.ioJobCreate("io-1", 2));
    scheduler_mod.schedulerSubmit(q, kind, network_factory.networkJobCreate("network-2", 3));
    scheduler_mod.schedulerSubmit(q, kind, batch_factory.batchJobCreate("batch-3", 4));
    scheduler_mod.schedulerSubmit(q, kind, report_factory.reportJobCreate("report-4", 5));
    scheduler_mod.schedulerSubmit(q, kind, cleanup_factory.cleanupJobCreate("cleanup-5", 6));
    scheduler_mod.schedulerSubmit(q, kind, backup_factory.backupJobCreate("backup-6", 7));
    scheduler_mod.schedulerSubmit(q, kind, notify_factory.notifyJobCreate("notify-7", 8));
    scheduler_mod.schedulerSubmit(q, kind, index_factory.indexJobCreate("index-8", 9));
    scheduler_mod.schedulerSubmit(q, kind, migrate_factory.migrateJobCreate("migrate-9", 1));
    scheduler_mod.schedulerSubmit(q, kind, archive_factory.archiveJobCreate("archive-10", 2));
    scheduler_mod.schedulerSubmit(q, kind, sync_factory.syncJobCreate("sync-11", 3));
    scheduler_mod.schedulerSubmit(q, kind, audit_factory.auditJobCreate("audit-12", 4));
}
