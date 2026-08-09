module Config

export config_get_precision, config_set_precision

const PRECISION = Ref{Int}(6)
const ANGLE_UNIT = Ref{String}("radians")

function config_get_precision()
    return PRECISION[]
end

function config_set_precision(digits::Int)
    PRECISION[] = digits
end

function config_angle_unit()
    return ANGLE_UNIT[]
end

end
