-- Named calculator function: trig arctan.
local mathutil = require("src.mathutil")

local function trig_arctan(x)
  local value = mathutil.guard_number(x)
  return math.atan(value)
end

return { trig_arctan = trig_arctan }
