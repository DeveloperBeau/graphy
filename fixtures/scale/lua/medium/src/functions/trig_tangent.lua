-- Named calculator function: trig tangent.
local mathutil = require("src.mathutil")

local function trig_tangent(x)
  local value = mathutil.guard_number(x)
  return math.tan(value)
end

return { trig_tangent = trig_tangent }
