-- Named calculator function: trig cosine.
local mathutil = require("src.mathutil")

local function trig_cosine(x)
  local value = mathutil.guard_number(x)
  return math.cos(value)
end

return { trig_cosine = trig_cosine }
