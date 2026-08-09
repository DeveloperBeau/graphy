local printer = require("printer")
local casing = require("casing")

local function run()
  printer.print_report(casing.title_case("weekly status"))
  printer.print_page("the quick brown fox jumps over the lazy dog", 24)
end

run()
