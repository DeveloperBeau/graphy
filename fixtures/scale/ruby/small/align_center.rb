def align_center(line, width)
  gap = [0, width - line.length].max
  left = gap / 2
  (" " * left) + line + (" " * (gap - left))
end
