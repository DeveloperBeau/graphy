package cryptobench.store

import cryptobench.core.SuiteResult
import java.io.BufferedWriter
import java.nio.file.Files
import java.nio.file.Path

/** Appends one JSON line per finished suite to results/run.jsonl. */
class ResultStore private constructor(private val writer: BufferedWriter) {

    fun append(result: SuiteResult) {
        writer.write(toJsonLine(ResultRecord.of(result)))
        writer.newLine()
        writer.flush()
    }

    fun close() {
        writer.close()
    }

    companion object {
        fun openAt(directory: Path): ResultStore {
            Files.createDirectories(directory)
            return ResultStore(Files.newBufferedWriter(directory.resolve("run.jsonl")))
        }
    }
}
