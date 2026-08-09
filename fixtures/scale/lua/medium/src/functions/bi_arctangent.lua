-- Named calculator function: bi arctangent.
local mathutil = require("src.mathutil")

local function bi_arctangent(a, b)
  local left = mathutil.guard_number(a)
  local right = mathutil.guard_number(b)
  return math.atan(left, right)
end

return { bi_arctangent = bi_arctangent }
