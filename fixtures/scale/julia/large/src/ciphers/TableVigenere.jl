module VigenereTable

# Registration table for the vigenere family.

using ..BenchRegistry
using ..VigenereRunner
using ..BeaufortRunner
using ..AutokeyRunner
using ..GronsfeldRunner
using ..PortaRunner
using ..RunkeyRunner
using ..KeymixRunner
using ..TrithemiusRunner
using ..QuagmireRunner

function register_vigenere_ciphers()
    BenchRegistry.register_cipher("vigenere", VigenereRunner.vigenere_run_bench)
    BenchRegistry.register_cipher("beaufort", BeaufortRunner.beaufort_run_bench)
    BenchRegistry.register_cipher("autokey", AutokeyRunner.autokey_run_bench)
    BenchRegistry.register_cipher("gronsfeld", GronsfeldRunner.gronsfeld_run_bench)
    BenchRegistry.register_cipher("porta", PortaRunner.porta_run_bench)
    BenchRegistry.register_cipher("runkey", RunkeyRunner.runkey_run_bench)
    BenchRegistry.register_cipher("keymix", KeymixRunner.keymix_run_bench)
    BenchRegistry.register_cipher("trithemius", TrithemiusRunner.trithemius_run_bench)
    BenchRegistry.register_cipher("quagmire", QuagmireRunner.quagmire_run_bench)
end

end
