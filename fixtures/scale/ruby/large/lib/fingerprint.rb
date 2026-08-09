def fingerprint(text)
  total = text.chars.sum(&:ord)
  format("%04x", total % 65_536)
end
