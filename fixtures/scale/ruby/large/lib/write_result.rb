require 'fileutils'
require_relative 'result_path'

def write_result(name, line)
  FileUtils.mkdir_p(store_dir)
  File.open(result_path(name), "a") { |fh| fh.puts(line) }
end
