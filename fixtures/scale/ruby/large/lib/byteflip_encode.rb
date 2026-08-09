def byteflip_encode(text)
  k = 4
  chunks = text.chars.each_slice(k).to_a
  chunks.map { |c| c.reverse.join }.join
end
