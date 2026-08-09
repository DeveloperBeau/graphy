-- Named calculator function: hyp tanh.
local mathutil = require("src.mathutil")

local function hyp_tanh(x)
  local value = mathutil.guard_number(x)
  return (math.exp(2 * value) - 1) / (math.exp(2 * value) + 1)
end

return { hyp_tanh = hyp_tanh }
