local formatter = require("report.formatter")

local function emit(result)
  local line = formatter.format_row(result)
  io.write(line .. "\n")
  return line
end

local function emit_banner(text)
  io.write("--- " .. text .. " ---\n")
end

return { emit = emit, emit_banner = emit_banner }
