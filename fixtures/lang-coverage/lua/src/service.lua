-- feature: require, function, method, call
local helpers = require("helpers")
local types = require("types")

local Service = {}
Service.__index = Service

function Service.new(name)
    local self = setmetatable({}, Service)
    self.name = name
    return self
end

function Service:run(mode)
    local greeting = helpers.format_name(self.name)
    return greeting, mode
end

function Service:describe()
    return "Service(" .. self.name .. ")"
end

function top_level_helper()
    return 42
end

return Service
