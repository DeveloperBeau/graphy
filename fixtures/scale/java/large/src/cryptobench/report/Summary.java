package cryptobench.report;

import java.util.ArrayList;
import java.util.List;

import cryptobench.core.SuiteResult;

import static cryptobench.report.TableFormat.formatRow;

public class Summary {
    private final List<SuiteResult> results = new ArrayList<>();

    public void add(SuiteResult result) {
        results.add(result);
    }

    public int totalFailed() {
        return results.stream().mapToInt(SuiteResult::getFailed).sum();
    }

    public String render() {
        StringBuilder sb = new StringBuilder();
        sb.append(TableFormat.header()).append('\n').append(TableFormat.rule()).append('\n');
        for (SuiteResult r : results) {
            sb.append(formatRow(r.getSuiteName(), r.getPassed(), r.getFailed(),
                    r.getElapsedNanos() / 1_000_000.0)).append('\n');
        }
        sb.append(results.size()).append(" suites, ").append(totalFailed()).append(" failures");
        return sb.toString();
    }
}
