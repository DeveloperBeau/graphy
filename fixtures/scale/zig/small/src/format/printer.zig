// prints parsed config entries as a table
const std = @import("std");
const entry = @import("../parser/entry.zig");
const table = @import("table.zig");

pub fn printerPrintEntries(entries: []const entry.Entry) void {
    table.tableRenderHeader();
    for (entries) |e| {
        table.tableRenderRow(e.key, e.value);
    }
}
