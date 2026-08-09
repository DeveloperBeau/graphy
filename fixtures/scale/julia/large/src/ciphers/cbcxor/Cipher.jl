module CbcXorCipher

# CbcXor cipher: xor chained against the previous cipher byte.

export cbcxor_encrypt, cbcxor_decrypt

const CBCXOR_IV = UInt8(113)

function cbcxor_keystream(cipher::Vector{UInt8})
    return vcat([CBCXOR_IV], cipher[1:(end - 1)])
end

function cbcxor_encrypt(data::Vector{UInt8})
    out = Vector{UInt8}(undef, length(data))
    prev = CBCXOR_IV
    for i in eachindex(data)
        out[i] = data[i] ⊻ prev
        prev = out[i]
    end
    return out
end

function cbcxor_decrypt(data::Vector{UInt8})
    return data .⊻ cbcxor_keystream(data)
end

end
