const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zix = b.dependency("zix", .{
        .target = target,
        .optimize = optimize
    });
    const pg_zig = b.dependency("pg", .{
        .target = target,
        .optimize = optimize
    });

    const exe = b.addExecutable(.{
        .name = "http_postgres_pg_zig",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    exe.root_module.addImport("zix", zix.module("zix"));
    exe.root_module.addImport("pg", pg_zig.module("pg"));

    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");

    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
}
