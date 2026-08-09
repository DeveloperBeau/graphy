def format_row(result)
  status = result[:ok] ? "OK " : "BAD"
  "#{status} #{result[:name].ljust(12)} fp=#{result[:fp]} #{result[:ms]}ms"
end
