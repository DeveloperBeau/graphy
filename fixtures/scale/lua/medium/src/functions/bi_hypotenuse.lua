-- Named calculator function: bi hypotenuse.
local mathutil = require("src.mathutil")

local function bi_hypotenuse(a, b)
  local left = mathutil.guard_number(a)
  local right = mathutil.guard_number(b)
  return math.sqrt(left * left + right * right)
end

return { bi_hypotenuse = bi_hypotenuse }
