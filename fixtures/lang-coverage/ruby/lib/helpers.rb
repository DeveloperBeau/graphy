# feature: top-level methods (module-level), called cross-file

module Helpers
  def self.format_name(name)
    "hi, " + name.to_s.strip
  end

  def self.unrelated_helper
    7
  end
end
