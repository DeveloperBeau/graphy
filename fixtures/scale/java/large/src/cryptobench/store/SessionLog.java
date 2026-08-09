package cryptobench.store;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.time.Instant;

public class SessionLog {
    private final Path logFile;

    public SessionLog(Path directory) {
        this.logFile = directory.resolve("session.log");
    }

    public void note(String message) {
        String line = Instant.now() + " " + message + System.lineSeparator();
        try {
            Files.writeString(logFile, line, StandardOpenOption.CREATE, StandardOpenOption.APPEND);
        } catch (IOException ignored) {
            // A missing session log never fails the run.
        }
    }
}
