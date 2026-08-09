package cryptobench.store;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.Path;

import cryptobench.core.SuiteResult;

import static cryptobench.store.JsonLines.toJson;

/** Appends one JSON line per finished suite to results/run.jsonl. */
public class ResultStore {
    private final BufferedWriter writer;

    private ResultStore(BufferedWriter writer) { this.writer = writer; }

    public static ResultStore openAt(Path directory) {
        try {
            Files.createDirectories(directory);
            return new ResultStore(Files.newBufferedWriter(directory.resolve("run.jsonl")));
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    public void append(SuiteResult result) {
        try {
            writer.write(toJson(new ResultRecord(result)) + System.lineSeparator());
            writer.flush();
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    public void close() {
        try { writer.close(); } catch (IOException e) { throw new UncheckedIOException(e); }
    }
}
