// wires parsing, validation and printing into one command
const std = @import("std");
const args_mod = @import("args.zig");
const parser = @import("../parser/parser.zig");
const schema_mod = @import("../validate/schema.zig");
const printer = @import("../format/printer.zig");

pub fn cliCommandsRun(allocator: std.mem.Allocator, options: args_mod.Options) !void {
    const parsed = try parser.parserParseFile(allocator, options.path);
    const schema = schema_mod.Schema{ .required_keys = &[_][]const u8{"name"} };
    const problems = schema_mod.schemaValidate(schema, parsed.entries[0..parsed.count]);
    if (options.verbose) {
        std.debug.print("problems found: {d}\n", .{problems});
    }
    printer.printerPrintEntries(parsed.entries[0..parsed.count]);
}
