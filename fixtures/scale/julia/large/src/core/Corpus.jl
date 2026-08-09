module BenchCorpus

export corpus_sample

const CORPUS_BASE = "the quick brown fox jumps over the lazy dog 0123456789"

function corpus_text(n::Int)
    reps = cld(n, length(CORPUS_BASE) + 1)
    return first(repeat(CORPUS_BASE * " ", reps), n)
end

function corpus_sample(n::Int = 512)
    return Vector{UInt8}(codeunits(corpus_text(n)))
end

end
