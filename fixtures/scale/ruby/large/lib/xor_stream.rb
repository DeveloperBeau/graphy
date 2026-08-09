def xor_stream(codes, key_codes)
  codes.each_with_index.map { |c, i| c ^ key_codes[i % key_codes.length] }
end
