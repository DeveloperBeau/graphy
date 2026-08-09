module Errors

export raise_calc, err_set, err_get

const LAST_ERROR = Ref{String}("")

struct CalcError <: Exception
    message::String
end

function raise_calc(message::String)
    throw(CalcError(message))
end

function err_set(message::String)
    LAST_ERROR[] = message
end

function err_get()
    return LAST_ERROR[]
end

end
