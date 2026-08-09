module BenchTimer

export timer_start, timer_elapsed_micros

function timer_start()
    return time_ns()
end

function timer_elapsed_micros(start::UInt64)
    return Int(div(time_ns() - start, 1000))
end

function timer_elapsed_millis(start::UInt64)
    return div(timer_elapsed_micros(start), 1000)
end

end
