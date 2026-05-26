module Types

# feature: abstract type, struct, const

export State, Service, MAX_RETRIES

const MAX_RETRIES = 3

abstract type State end

struct IdleState <: State end
struct RunningState <: State end

struct Service
    name::String
    state::State
end

end # module
