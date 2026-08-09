-- Named calculator function: round trunc.
local mathutil = require("src.mathutil")

local function round_trunc(x)
  local value = mathutil.guard_number(x)
  return value >= 0 and math.floor(value) or math.ceil(value)
end

return { round_trunc = round_trunc }
