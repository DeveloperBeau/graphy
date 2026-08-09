-- Named calculator function: bi minimum.
local mathutil = require("src.mathutil")

local function bi_minimum(a, b)
  local left = mathutil.guard_number(a)
  local right = mathutil.guard_number(b)
  return math.min(left, right)
end

return { bi_minimum = bi_minimum }
