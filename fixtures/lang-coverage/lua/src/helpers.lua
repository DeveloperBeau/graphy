-- feature: global functions, local functions
local M = {}

function M.format_name(name)
    return "hi, " .. name
end

local function unrelated_helper()
    return 7
end

M.helper = unrelated_helper

return M
