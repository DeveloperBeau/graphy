def wrap_text(text, width)
  words = text.split(" ")
  lines = []
  current = ""
  words.each do |word|
    if (current + word).length + 1 > width
      lines << current.strip
      current = ""
    end
    current += word + " "
  end
  lines << current.strip unless current.strip.empty?
  lines
end
