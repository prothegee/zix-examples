const std = @import("std");
const zix = @import("zix");

pub const registration_path = "/api/user";
pub fn registration(req: *zix.Http.Request, res: *zix.Http.Response, ctx: *zix.Http.Context) !void {
    _ = ctx; _ = req;

    // tmp
    try res.sendJson("null");
}
