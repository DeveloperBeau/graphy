-- Named calculator function: hyp sinh.
local mathutil = require("src.mathutil")

local function hyp_sinh(x)
  local value = mathutil.guard_number(x)
  return (math.exp(value) - math.exp(-value)) / 2
end

return { hyp_sinh = hyp_sinh }
