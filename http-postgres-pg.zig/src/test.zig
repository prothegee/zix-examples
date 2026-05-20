const std = @import("std");

fn doSomething(x: i32, y: i32) void {
    // need to be silent
    _ = x; _ = y;
}

pub fn main() !void {
    doSomething(32, 12);

    std.log.debug("", .{});
}
