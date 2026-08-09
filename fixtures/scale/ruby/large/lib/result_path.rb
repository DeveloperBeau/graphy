require 'fileutils'

def store_dir
  File.join(Dir.pwd, "runs")
end

def result_path(name)
  File.join(store_dir, "#{name}.log")
end
