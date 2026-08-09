module BenchConfig

export config_warmup, config_verbose

function config_env(name::String, fallback::String)
    value = get(ENV, name, "")
    return isempty(value) ? fallback : value
end

function config_warmup()
    return parse(Int, config_env("CIPHBENCH_WARMUP", "2"))
end

function config_verbose()
    return config_env("CIPHBENCH_VERBOSE", "0") == "1"
end

end
