module XorRollCipher

# XorRoll cipher: xor against an LCG key stream (a=75, c=74).

export xorroll_encrypt, xorroll_decrypt

function xorroll_keystream(n::Int)
    state = 193
    ks = Vector{UInt8}(undef, n)
    for i in 1:n
        state = mod(state * 75 + 74, 65537)
        ks[i] = UInt8(state % 256)
    end
    return ks
end

function xorroll_encrypt(data::Vector{UInt8})
    return data .⊻ xorroll_keystream(length(data))
end

function xorroll_decrypt(data::Vector{UInt8})
    # Xor stream ciphers are symmetric.
    return xorroll_encrypt(data)
end

end
