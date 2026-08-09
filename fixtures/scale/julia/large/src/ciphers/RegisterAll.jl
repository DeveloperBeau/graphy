module CipherTables

# One call wires every cipher family into the registry.

using ..ShiftTable
using ..VigenereTable
using ..StreamTable
using ..TranspositionTable
using ..HashTable

export register_everything

function register_everything()
    ShiftTable.register_shift_ciphers()
    VigenereTable.register_vigenere_ciphers()
    StreamTable.register_stream_ciphers()
    TranspositionTable.register_transposition_ciphers()
    HashTable.register_hash_ciphers()
end

end
