-- Named calculator function: round nearest.
local mathutil = require("src.mathutil")

local function round_nearest(x)
  local value = mathutil.guard_number(x)
  return math.floor(value + 0.5)
end

return { round_nearest = round_nearest }
