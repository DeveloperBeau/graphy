-- Named calculator function: pow square.
local mathutil = require("src.mathutil")

local function pow_square(x)
  local value = mathutil.guard_positive(x)
  return value * value
end

return { pow_square = pow_square }
