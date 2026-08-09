package cryptobench.cli

data class Args(
    val filter: String,
    val iterations: Int,
    val outDir: String,
) {
    companion object {
        fun parse(argv: Array<String>): Args {
            var filter = ""
            var iterations = 100
            var outDir = "results"
            for (arg in argv) {
                when {
                    arg.startsWith("--only=") -> filter = arg.substringAfter('=')
                    arg.startsWith("--iterations=") -> iterations = arg.substringAfter('=').toInt()
                    arg.startsWith("--out=") -> outDir = arg.substringAfter('=')
                }
            }
            return Args(filter, iterations, outDir)
        }
    }
}
