package cryptobench.cli

final case class Args(filter: String, iterations: Int, outDir: String)

object Args {
  def parse(argv: Array[String]): Args =
    argv.foldLeft(Args("", 100, "results")) { (args, arg) =>
      if (arg.startsWith("--only=")) args.copy(filter = arg.substring(7))
      else if (arg.startsWith("--iterations=")) args.copy(iterations = arg.substring(13).toInt)
      else if (arg.startsWith("--out=")) args.copy(outDir = arg.substring(6))
      else args
    }
}
