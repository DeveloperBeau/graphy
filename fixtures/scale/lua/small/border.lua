local theme = require("theme")

local function top(width, name)
  local c = theme.chars(name)
  return c.corner .. string.rep(c.edge, width) .. c.corner
end

return { top = top }
