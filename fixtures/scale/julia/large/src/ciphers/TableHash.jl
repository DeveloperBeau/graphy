module HashTable

# Registration table for the hash family.

using ..BenchRegistry
using ..Fnv1aRunner
using ..Djb2Runner
using ..SdbmRunner
using ..AdlerRunner
using ..Sum32Runner
using ..XorDigestRunner
using ..CrcLiteRunner
using ..RotHashRunner
using ..ProdHashRunner

function register_hash_ciphers()
    BenchRegistry.register_cipher("fnv1a", Fnv1aRunner.fnv1a_run_bench)
    BenchRegistry.register_cipher("djb2", Djb2Runner.djb2_run_bench)
    BenchRegistry.register_cipher("sdbm", SdbmRunner.sdbm_run_bench)
    BenchRegistry.register_cipher("adler", AdlerRunner.adler_run_bench)
    BenchRegistry.register_cipher("sum32", Sum32Runner.sum32_run_bench)
    BenchRegistry.register_cipher("xordigest", XorDigestRunner.xordigest_run_bench)
    BenchRegistry.register_cipher("crclite", CrcLiteRunner.crclite_run_bench)
    BenchRegistry.register_cipher("rothash", RotHashRunner.rothash_run_bench)
    BenchRegistry.register_cipher("prodhash", ProdHashRunner.prodhash_run_bench)
end

end
