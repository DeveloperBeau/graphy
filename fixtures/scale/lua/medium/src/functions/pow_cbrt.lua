-- Named calculator function: pow cbrt.
local mathutil = require("src.mathutil")

local function pow_cbrt(x)
  local value = mathutil.guard_positive(x)
  return value ^ (1 / 3)
end

return { pow_cbrt = pow_cbrt }
