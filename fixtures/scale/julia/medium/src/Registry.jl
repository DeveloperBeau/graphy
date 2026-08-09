module Registry

export registry_add, registry_contains, registry_size

const NAMES = String[]

function registry_add(name::String)
    push!(NAMES, name)
end

function registry_contains(name::String)
    return name in NAMES
end

function registry_size()
    return length(NAMES)
end

end
