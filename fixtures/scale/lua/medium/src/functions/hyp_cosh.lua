-- Named calculator function: hyp cosh.
local mathutil = require("src.mathutil")

local function hyp_cosh(x)
  local value = mathutil.guard_number(x)
  return (math.exp(value) + math.exp(-value)) / 2
end

return { hyp_cosh = hyp_cosh }
