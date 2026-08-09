module Style

export apply_style

function style_bold(text::String)
    return "\e[1m$(text)\e[0m"
end

function style_underline(text::String)
    return "\e[4m$(text)\e[0m"
end

function apply_style(style::String, text::String)
    style == "bold" && return style_bold(text)
    style == "underline" && return style_underline(text)
    return text
end

end
