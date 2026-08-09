-- Named calculator function: bi maximum.
local mathutil = require("src.mathutil")

local function bi_maximum(a, b)
  local left = mathutil.guard_number(a)
  local right = mathutil.guard_number(b)
  return math.max(left, right)
end

return { bi_maximum = bi_maximum }
