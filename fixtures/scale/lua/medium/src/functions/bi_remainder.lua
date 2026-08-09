-- Named calculator function: bi remainder.
local mathutil = require("src.mathutil")

local function bi_remainder(a, b)
  local left = mathutil.guard_number(a)
  local right = mathutil.guard_number(b)
  return math.fmod(left, right)
end

return { bi_remainder = bi_remainder }
