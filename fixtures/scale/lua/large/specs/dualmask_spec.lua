local function get()
  return { name = "dualmask", category = "mask", key = 5 }
end

local function notes()
  return "xor archetype, fixture key 5"
end

return { get = get, notes = notes }
