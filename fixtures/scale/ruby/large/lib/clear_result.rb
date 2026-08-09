require 'fileutils'
require_relative 'result_path'

def clear_result(name)
  FileUtils.mkdir_p(store_dir)
  File.write(result_path(name), "")
end
