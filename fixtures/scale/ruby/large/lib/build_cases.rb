def sample_texts
  ["attack at dawn", "the quick brown fox", "hello world"]
end

def build_cases
  keys = { "caesar" => 7, "xorkey" => 3 }
  keys.flat_map { |name, key| sample_texts.map { |text| [name, text, key] } }
end
