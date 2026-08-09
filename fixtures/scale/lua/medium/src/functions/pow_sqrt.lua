-- Named calculator function: pow sqrt.
local mathutil = require("src.mathutil")

local function pow_sqrt(x)
  local value = mathutil.guard_positive(x)
  return math.sqrt(value)
end

return { pow_sqrt = pow_sqrt }
