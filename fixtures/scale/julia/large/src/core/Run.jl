module BenchRun

using ..BenchRegistry
using ..BenchTimer
using ..BenchStore
using ..BenchCsv
using ..BenchProgress
using ..BenchCorpus
using ..BenchSummary
using ..BenchArgs

export bench_all, verify_all

function bench_one(name::String, runner::Function, sample::Vector{UInt8})
    start = BenchTimer.timer_start()
    len = runner(sample, BenchArgs.option_get("rounds"))
    micros = BenchTimer.timer_elapsed_micros(start)
    BenchStore.store_append(BenchCsv.csv_row([name, string(len), string(micros)]))
    BenchProgress.progress_tick(name)
end

function bench_all()
    sample = BenchCorpus.corpus_sample(BenchArgs.option_get("sample_size"))
    BenchStore.store_init()
    BenchStore.store_append(BenchCsv.csv_header())
    BenchProgress.progress_start(BenchRegistry.registered_count())
    for (name, runner) in BenchRegistry.registered_ciphers()
        bench_one(name, runner, sample)
    end
    BenchProgress.progress_done()
    BenchSummary.summary_print()
end

function verify_all()
    for (name, _) in BenchRegistry.registered_ciphers()
        println("registered: ", name)
    end
end

end
