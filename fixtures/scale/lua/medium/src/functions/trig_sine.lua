-- Named calculator function: trig sine.
local mathutil = require("src.mathutil")

local function trig_sine(x)
  local value = mathutil.guard_number(x)
  return math.sin(value)
end

return { trig_sine = trig_sine }
