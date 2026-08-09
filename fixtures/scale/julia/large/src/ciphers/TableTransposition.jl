module TranspositionTable

# Registration table for the transposition family.

using ..BenchRegistry
using ..RailFenceRunner
using ..ColumnarRunner
using ..ScytaleRunner
using ..RevBlocksRunner
using ..ZigZagRunner
using ..BlockSwapRunner
using ..RotBlocksRunner
using ..InterleaveRunner
using ..StrideRunner

function register_transposition_ciphers()
    BenchRegistry.register_cipher("railfence", RailFenceRunner.railfence_run_bench)
    BenchRegistry.register_cipher("columnar", ColumnarRunner.columnar_run_bench)
    BenchRegistry.register_cipher("scytale", ScytaleRunner.scytale_run_bench)
    BenchRegistry.register_cipher("revblocks", RevBlocksRunner.revblocks_run_bench)
    BenchRegistry.register_cipher("zigzag", ZigZagRunner.zigzag_run_bench)
    BenchRegistry.register_cipher("blockswap", BlockSwapRunner.blockswap_run_bench)
    BenchRegistry.register_cipher("rotblocks", RotBlocksRunner.rotblocks_run_bench)
    BenchRegistry.register_cipher("interleave", InterleaveRunner.interleave_run_bench)
    BenchRegistry.register_cipher("stride", StrideRunner.stride_run_bench)
end

end
