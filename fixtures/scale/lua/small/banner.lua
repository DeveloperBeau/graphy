local format = require("format")

local function make_banner(title)
  local loud = format.to_upper(title)
  return format.underline(loud)
end

local function boxed(title)
  local bar = format.repeat_char("*", 30)
  return table.concat({ bar, make_banner(title), bar }, "\n")
end

return { make_banner = make_banner, boxed = boxed }
