local function sample_texts()
  return { "attack at dawn", "the quick brown fox", "hello world" }
end

local function build_cases()
  local keys = { caesar = 7, xorkey = 3 }
  local cases = {}
  for name, key in pairs(keys) do
    for _, text in ipairs(sample_texts()) do
      table.insert(cases, { name, text, key })
    end
  end
  return cases
end

return { sample_texts = sample_texts, build_cases = build_cases }
