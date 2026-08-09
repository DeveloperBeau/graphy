package cryptobench.store

import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.StandardOpenOption
import java.time.Instant

class SessionLog(directory: Path) {
    private val logFile = directory.resolve("session.log")

    fun note(message: String) {
        val line = Instant.now().toString() + " " + message + System.lineSeparator()
        runCatching {
            Files.writeString(logFile, line, StandardOpenOption.CREATE, StandardOpenOption.APPEND)
        }
    }
}
