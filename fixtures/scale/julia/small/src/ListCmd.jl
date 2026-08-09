module ListCmd

using ..Style
using ..Log

export cmd_list

function list_item(item::String)
    return "  * " * item
end

function cmd_list(items::Vector{String})
    Log.log_info("list with", length(items), "items")
    for item in items
        println(list_item(item))
    end
end

end
