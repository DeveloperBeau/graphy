defmodule Cryptobench do
  alias Ciphers.Aes128.Runner
  alias Core.Benchmark
  alias Core.Config
  alias Core.Progress
  alias Core.Registry
  alias Core.Store
  alias Support.Report
  alias Support.Vectors

  def main do
    vector = Vectors.sample(42, 64)
    result = Runner.run_case(vector.key, vector.plaintext)
    bench = Benchmark.run("aes-128", [result])
    Progress.emit(1, Registry.size())
    IO.puts("\n" <> Report.summary([result]))
    Store.save(Config.defaults(), [result])
    bench
  end
end
