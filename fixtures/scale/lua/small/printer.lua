local banner = require("banner")
local layout = require("layout")
local border = require("border")

local function print_report(title)
  print(banner.boxed(title))
  print(border.top(30, "plain"))
end

local function print_page(text, cols)
  print(layout.render_page(text, cols))
end

return { print_report = print_report, print_page = print_page }
