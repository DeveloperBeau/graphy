package cryptobench.store

import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.StandardOpenOption
import java.time.Instant

import scala.util.Try

final class SessionLog(directory: Path) {
  private val logFile = directory.resolve("session.log")

  def note(message: String): Unit = {
    val line = Instant.now().toString + " " + message + System.lineSeparator()
    Try(Files.writeString(logFile, line, StandardOpenOption.CREATE, StandardOpenOption.APPEND))
    ()
  }
}
