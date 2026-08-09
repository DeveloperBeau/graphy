def stridecode_encode(text)
  k = 2
  chunks = text.chars.each_slice(k).to_a
  chunks.map { |c| c.reverse.join }.join
end
