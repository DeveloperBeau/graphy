// validation error kinds and their human-readable descriptions
const std = @import("std");

pub const ValidationError = enum {
    MissingKey,
    EmptyValue,
    UnknownKey,
};

pub fn errorsDescribe(err: ValidationError) []const u8 {
    return switch (err) {
        .MissingKey => "required key is missing",
        .EmptyValue => "value must not be empty",
        .UnknownKey => "key is not recognized by the schema",
    };
}
