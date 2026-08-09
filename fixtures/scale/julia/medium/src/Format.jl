module Format

using ..Config

export fmt_result

function fmt_number(value::Float64)
    precision = Config.config_get_precision()
    return string(round(value; digits = precision))
end

function fmt_result(value::Float64)
    return "= " * fmt_number(value)
end

function fmt_hex(value::Int)
    return string("0x", string(value, base = 16))
end

end
