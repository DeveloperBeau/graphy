-- feature: functions, table constructors
local M = {}

M.MAX_RETRIES = 3
M.SERVICE_NAME = "graphy-lua-fixture"

function M.new_state(name)
    return { name = name, active = false }
end

return M
