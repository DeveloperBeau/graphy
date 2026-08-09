module BenchLog

using Dates

export log_write, log_info, log_warn

function log_write(level::String, parts...)
    stamp = Dates.format(Dates.now(), "HH:MM:SS")
    println(stderr, stamp, " [", level, "] ", join(parts, " "))
end

function log_info(parts...)
    log_write("INFO", parts...)
end

function log_warn(parts...)
    log_write("WARN", parts...)
end

end
