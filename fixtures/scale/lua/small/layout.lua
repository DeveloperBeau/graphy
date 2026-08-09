local wrap = require("wrap")
local align = require("align")
local width = require("width")

local function render_page(text, cols)
  local lines = wrap.wrap_text(text, cols)
  local body = width.max_width(lines)
  local centered = {}
  for i, line in ipairs(lines) do
    centered[i] = align.align_center(line, body)
  end
  return table.concat(centered, "\n")
end

return { render_page = render_page }
