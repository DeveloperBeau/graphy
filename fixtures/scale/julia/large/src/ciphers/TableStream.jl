module StreamTable

# Registration table for the stream family.

using ..BenchRegistry
using ..XorBasicRunner
using ..XorRollRunner
using ..Rc4LiteRunner
using ..LcgStreamRunner
using ..XorShiftRunner
using ..FeistelRunner
using ..CbcXorRunner
using ..CtrXorRunner
using ..MaskStreamRunner

function register_stream_ciphers()
    BenchRegistry.register_cipher("xorbasic", XorBasicRunner.xorbasic_run_bench)
    BenchRegistry.register_cipher("xorroll", XorRollRunner.xorroll_run_bench)
    BenchRegistry.register_cipher("rc4lite", Rc4LiteRunner.rc4lite_run_bench)
    BenchRegistry.register_cipher("lcgstream", LcgStreamRunner.lcgstream_run_bench)
    BenchRegistry.register_cipher("xorshift", XorShiftRunner.xorshift_run_bench)
    BenchRegistry.register_cipher("feistel", FeistelRunner.feistel_run_bench)
    BenchRegistry.register_cipher("cbcxor", CbcXorRunner.cbcxor_run_bench)
    BenchRegistry.register_cipher("ctrxor", CtrXorRunner.ctrxor_run_bench)
    BenchRegistry.register_cipher("maskstream", MaskStreamRunner.maskstream_run_bench)
end

end
