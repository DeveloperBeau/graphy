package cryptobench.cli

class Args {
    String filter
    int iterations
    String outDir

    Args(String filter, int iterations, String outDir) {
        this.filter = filter
        this.iterations = iterations
        this.outDir = outDir
    }

    static Args parse(String[] argv) {
        String filter = ""
        int iterations = 100
        String outDir = "results"
        argv.each { arg ->
            if (arg.startsWith("--only=")) filter = arg.substring(7)
            else if (arg.startsWith("--iterations=")) iterations = arg.substring(13).toInteger()
            else if (arg.startsWith("--out=")) outDir = arg.substring(6)
        }
        return new Args(filter, iterations, outDir)
    }
}
