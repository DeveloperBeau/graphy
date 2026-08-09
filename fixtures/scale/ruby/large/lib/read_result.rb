require_relative 'result_path'

def read_result(name)
  path = result_path(name)
  return [] unless File.exist?(path)
  File.readlines(path).map(&:chomp)
end
