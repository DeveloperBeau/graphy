-- Named calculator function: pow cube.
local mathutil = require("src.mathutil")

local function pow_cube(x)
  local value = mathutil.guard_positive(x)
  return value * value * value
end

return { pow_cube = pow_cube }
