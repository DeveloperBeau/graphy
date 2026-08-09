-- Named calculator function: pow exp.
local mathutil = require("src.mathutil")

local function pow_exp(x)
  local value = mathutil.guard_positive(x)
  return math.exp(value)
end

return { pow_exp = pow_exp }
