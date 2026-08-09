module BlockSwapCipher

# BlockSwap cipher: block transposition with period 8.

export blockswap_encrypt, blockswap_decrypt

const BLOCKSWAP_PERM = [5, 6, 7, 8, 1, 2, 3, 4]
const BLOCKSWAP_INV = [5, 6, 7, 8, 1, 2, 3, 4]

function blockswap_apply(data::Vector{UInt8}, order::Vector{Int})
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

function blockswap_encrypt(data::Vector{UInt8})
    return blockswap_apply(data, BLOCKSWAP_PERM)
end

function blockswap_decrypt(data::Vector{UInt8})
    return blockswap_apply(data, BLOCKSWAP_INV)
end

end
