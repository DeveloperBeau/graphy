module Memory

export mem_store, mem_recall, mem_clear

const SLOT = Ref{Float64}(0.0)

function mem_store(value::Float64)
    SLOT[] = value
end

function mem_recall()
    return SLOT[]
end

function mem_clear()
    SLOT[] = 0.0
end

end
