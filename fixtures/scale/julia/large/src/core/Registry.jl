module BenchRegistry

export register_cipher, registered_ciphers, registered_count

const CIPHERS = Vector{Tuple{String, Function}}()

function register_cipher(name::String, runner::Function)
    push!(CIPHERS, (name, runner))
end

function registered_ciphers()
    return copy(CIPHERS)
end

function registered_count()
    return length(CIPHERS)
end

end
