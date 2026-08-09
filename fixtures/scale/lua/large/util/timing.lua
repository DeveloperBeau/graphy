local function now_ms()
  return math.floor(os.clock() * 1000)
end

local function elapsed(start_ms)
  return now_ms() - start_ms
end

return { now_ms = now_ms, elapsed = elapsed }
