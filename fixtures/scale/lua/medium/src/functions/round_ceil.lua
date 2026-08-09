-- Named calculator function: round ceil.
local mathutil = require("src.mathutil")

local function round_ceil(x)
  local value = mathutil.guard_number(x)
  return math.ceil(value)
end

return { round_ceil = round_ceil }
