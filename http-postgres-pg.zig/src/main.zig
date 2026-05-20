const std = @import("std");

const pg = @import("pg");
const zix = @import("zix");

const IP: []const u8 = "127.0.0.1";
const PORT: u16 = 9005;
const DISPATCH_MODEL: zix.Http.DispatchModel = .ASYNC;
const MAX_KERNEL_BACKLOG: usize = 1024 * 4;
const MAX_CLIENT_REQUEST: usize = 1024 * 4;
const MAX_ALLOCATOR_SIZE: usize = 1024 * 4;
const MAX_CLIENT_RESPONSE: usize = 1024 * 4;
const WORKERS: usize = 0; // 0 = auto (cpu_count accept threads)
const POOL_SIZE: usize = 0; // 0 = auto (max(10, cpu_count * 2) pool threads)

const MAX_PATH_SEGMENTS: usize = 9;

const handlerRegistrar = @import("./handler_registrar.zig");

pub fn main(process: std.process.Init) !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.smp_allocator);
    defer arena.deinit();

    var server = try zix.Http.Server.init(4096, .{
        .io = process.io,
        .allocator = arena.allocator(),
        .ip = IP,
        .port = PORT,
        .dispatch_model = DISPATCH_MODEL,
        .max_kernel_backlog = MAX_KERNEL_BACKLOG,
        .max_client_request = MAX_CLIENT_REQUEST,
        .max_allocator_size = MAX_ALLOCATOR_SIZE,
        .max_client_response = MAX_CLIENT_RESPONSE,
        .workers = WORKERS,
        .pool_size = POOL_SIZE,
    });
    defer server.deinit();

    try handlerRegistrar.initialize(&server);
}
