local function count_ok(results)
  local n = 0
  for _, r in ipairs(results) do
    if r.ok then n = n + 1 end
  end
  return n
end

return { count_ok = count_ok }
