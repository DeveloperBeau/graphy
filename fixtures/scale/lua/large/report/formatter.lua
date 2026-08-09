local function format_row(result)
  local status = result.ok and "OK " or "BAD"
  return string.format("%s %-12s fp=%s %dms", status, result.name, result.fp, result.ms)
end

local function format_header()
  return "=== cipher round-trip report ==="
end

local function format_check(name, ok)
  return (ok and "PASS" or "FAIL") .. " check " .. name
end

return { format_row = format_row, format_header = format_header, format_check = format_check }
