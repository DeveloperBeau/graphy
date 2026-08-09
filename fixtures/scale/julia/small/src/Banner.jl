module Banner

using ..Colors
using ..Align
using ..Border
using ..Log
using ..Config

export cmd_banner

function cmd_banner(text::String)
    width = Config.config_get("width")
    Log.log_info("banner width =", width)
    centered = Align.center_text(text, width)
    for line in Border.border_wrap([centered], width)
        println(line)
    end
end

function banner_preview(text::String)
    return Colors.colorize("cyan", Align.center_text(text, 40))
end

end
