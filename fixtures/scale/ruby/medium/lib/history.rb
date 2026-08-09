require_relative 'format_line'

class History
  def initialize
    @entries = []
  end

  def record(expr, value)
    @entries << format_line(expr, value)
  end

  def dump
    @entries.join("\n")
  end
end
