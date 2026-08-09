module ShiftTable

# Registration table for the shift family.

using ..BenchRegistry
using ..CaesarRunner
using ..Rot13Runner
using ..Rot47Runner
using ..Shift5Runner
using ..AtbashRunner
using ..AffineRunner
using ..DecimationRunner
using ..AddmodRunner
using ..RotmixRunner

function register_shift_ciphers()
    BenchRegistry.register_cipher("caesar", CaesarRunner.caesar_run_bench)
    BenchRegistry.register_cipher("rot13", Rot13Runner.rot13_run_bench)
    BenchRegistry.register_cipher("rot47", Rot47Runner.rot47_run_bench)
    BenchRegistry.register_cipher("shift5", Shift5Runner.shift5_run_bench)
    BenchRegistry.register_cipher("atbash", AtbashRunner.atbash_run_bench)
    BenchRegistry.register_cipher("affine", AffineRunner.affine_run_bench)
    BenchRegistry.register_cipher("decimation", DecimationRunner.decimation_run_bench)
    BenchRegistry.register_cipher("addmod", AddmodRunner.addmod_run_bench)
    BenchRegistry.register_cipher("rotmix", RotmixRunner.rotmix_run_bench)
end

end
