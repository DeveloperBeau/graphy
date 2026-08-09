module ColumnarCipher

# Columnar cipher: block transposition with period 4.

export columnar_encrypt, columnar_decrypt

const COLUMNAR_PERM = [4, 2, 1, 3]
const COLUMNAR_INV = [3, 2, 4, 1]

function columnar_apply(data::Vector{UInt8}, order::Vector{Int})
    p = length(order)
    out = copy(data)
    for blk in 0:(div(length(data), p) - 1)
        base = blk * p
        for j in 1:p
            out[base + j] = data[base + order[j]]
        end
    end
    return out
end

function columnar_encrypt(data::Vector{UInt8})
    return columnar_apply(data, COLUMNAR_PERM)
end

function columnar_decrypt(data::Vector{UInt8})
    return columnar_apply(data, COLUMNAR_INV)
end

end
