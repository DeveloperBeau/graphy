module Repl

using ..Eval
using ..History
using ..Format
using ..Errors

export repl_loop

function repl_prompt()
    print("calc> ")
    return readline()
end

function repl_loop()
    while true
        line = repl_prompt()
        line == "quit" && break
        try
            result = Eval.eval_expr(line)
            History.history_add(line, result)
            println(Format.fmt_result(result))
        catch err
            Errors.err_set(sprint(showerror, err))
            println("error: ", Errors.err_get())
        end
    end
end

end
