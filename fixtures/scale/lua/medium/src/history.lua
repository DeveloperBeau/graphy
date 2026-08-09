local formatting = require("src.formatting")

local function new_history()
  return { entries = {} }
end

local function record(hist, expr, value)
  table.insert(hist.entries, formatting.format_line(expr, value))
end

local function dump(hist)
  return table.concat(hist.entries, "\n")
end

return { new_history = new_history, record = record, dump = dump }
