package cryptobench.store

import java.io.BufferedWriter
import java.nio.file.Files
import java.nio.file.Path

import cryptobench.core.SuiteResult

/** Appends one JSON line per finished suite to results/run.jsonl. */
final class ResultStore private (writer: BufferedWriter) {

  def append(result: SuiteResult): Unit = {
    writer.write(JsonLines.toJson(ResultRecord.of(result)))
    writer.newLine()
    writer.flush()
  }

  def close(): Unit = writer.close()
}

object ResultStore {
  def openAt(directory: Path): ResultStore = {
    Files.createDirectories(directory)
    new ResultStore(Files.newBufferedWriter(directory.resolve("run.jsonl")))
  }
}
