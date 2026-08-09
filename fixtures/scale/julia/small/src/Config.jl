module Config

export config_get, use_color

const DEFAULTS = Dict("width" => "72", "style" => "plain", "color" => "auto")

function config_get(name::String)
    envkey = "TEXTPRINT_" * uppercase(name)
    value = get(ENV, envkey, get(DEFAULTS, name, ""))
    isempty(value) && error("unknown setting: $name")
    return name == "width" ? parse(Int, value) : value
end

function use_color()
    return config_get("color") != "never"
end

end
