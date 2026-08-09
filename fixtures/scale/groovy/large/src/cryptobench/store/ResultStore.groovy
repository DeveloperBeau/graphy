package cryptobench.store

import java.nio.file.Files
import java.nio.file.Path

import cryptobench.core.SuiteResult

/** Appends one JSON line per finished suite to results/run.jsonl. */
class ResultStore {
    private final BufferedWriter writer

    private ResultStore(BufferedWriter writer) {
        this.writer = writer
    }

    static ResultStore openAt(Path directory) {
        Files.createDirectories(directory)
        return new ResultStore(Files.newBufferedWriter(directory.resolve("run.jsonl")))
    }

    void append(SuiteResult result) {
        writer.write(JsonLines.toJson(new ResultRecord(result)))
        writer.newLine()
        writer.flush()
    }

    void close() {
        writer.close()
    }
}
