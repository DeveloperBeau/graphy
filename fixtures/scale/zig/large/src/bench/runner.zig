// runs the full registry and folds the results into summary stats
const std = @import("std");
const registry_mod = @import("registry.zig");
const entry_mod = @import("entry.zig");
const collect_mod = @import("collect.zig");
const stats_mod = @import("../core/stats.zig");
const hexdump_mod = @import("../core/hexdump.zig");

pub fn benchRunnerExecuteAll() void {
    var entries: [registry_mod.family_count]entry_mod.BenchEntry = undefined;
    registry_mod.benchRegistryRunAll(&entries);
    const ok_count = collect_mod.benchCollectCountOk(&entries);
    const digest_sum = collect_mod.benchCollectDigestSum(&entries);
    const folded = hexdump_mod.hexdumpFold(digest_sum);
    std.debug.print("families ok: {d}/{d}, folded digest sum: {d}\n", .{ ok_count, registry_mod.family_count, folded });
}
