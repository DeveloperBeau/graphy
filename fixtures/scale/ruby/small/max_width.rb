def max_width(lines)
  return 0 if lines.empty?
  lines.map(&:length).max
end
