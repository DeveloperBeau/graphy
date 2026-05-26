module Service

# feature: module, using, import, function, struct, const, call

using LinearAlgebra
import Helpers: format_name

export run_service, make_service

const SERVICE_VERSION = "1.0"

struct ServiceConfig
    name::String
    max_retries::Int
end

function make_service(name::String)
    return ServiceConfig(name, 3)
end

function run_service(cfg::ServiceConfig)
    msg = format_name(cfg.name)
    println(msg)
    return cfg.max_retries
end

end # module
