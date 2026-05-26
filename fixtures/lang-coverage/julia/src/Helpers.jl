module Helpers

# feature: module, function, multiple dispatch

export format_name, unrelated_helper

function format_name(name::String)
    return "hi, " * name
end

function format_name(name::String, prefix::String)
    return prefix * ", " * name
end

unrelated_helper() = 7

end # module
