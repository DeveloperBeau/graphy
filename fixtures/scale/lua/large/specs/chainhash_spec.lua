local function get()
  return { name = "chainhash", category = "hash", key = 15 }
end

local function notes()
  return "hash archetype, fixture key 15"
end

return { get = get, notes = notes }
