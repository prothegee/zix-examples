const std = @import("std");
const zix = @import("zix");

const user = @import("./handlers/user_handler.zig");

// --------------------------------------------------------- //

/// params:
/// ZixHttpServer - zix http server
pub fn initialize(ZixHttpServer: anytype) !void {
    ZixHttpServer.registerParamHandler(user.registration_path, user.registration);
}
