-- Named calculator function: round floor.
local mathutil = require("src.mathutil")

local function round_floor(x)
  local value = mathutil.guard_number(x)
  return math.floor(value)
end

return { round_floor = round_floor }
