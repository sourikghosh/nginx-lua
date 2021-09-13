local jwt = require "resty.jwt"
local cjson = require "cjson"
local basexx = require "basexx"
local secret = os.getenv("JWT_SECRET")

assert(secret ~= nil, "Environment variable JWT_SECRET not set")

local M = {}

function M.auth()
    -- require Authorization request header

    local auth_header = ngx.var.http_Authorization
    if auth_header == nil then
        ngx.log(ngx.WARN, "No Authorization header")
        ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end

    -- require Bearer token
    local _, _, token = string.find(auth_header, "Bearer%s+(.+)")
    if token == nil then
        ngx.log(ngx.WARN, "Missing token")
        ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end


    -- require valid JWT
    local jwt_object = jwt:verify(secret, token, 0)
    if jwt_object.verified == false then
        ngx.log(ngx.WARN, "Invalid token: ".. jwt_object.reason)
        ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end
    

    local org_encoded = cjson.encode(jwt_object.payload.orgData)
    local orgdata_base64 = basexx.to_base64(org_encoded)
    ngx.var.userId = jwt_object.payload.userId
    ngx.var.org_data = orgdata_base64
end

return M
