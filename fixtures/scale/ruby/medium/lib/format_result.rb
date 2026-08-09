def format_result(value)
  return value.to_i.to_s if value == value.to_i
  format("%.4f", value)
end
