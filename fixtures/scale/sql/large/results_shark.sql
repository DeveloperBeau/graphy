-- Ranked nightly result rows for SHARK.
CREATE TABLE results_shark (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_shark_summary_idx ON results_shark (run_summary_id);

CREATE INDEX results_shark_run_summary_id_idx ON results_shark (run_summary_id);

CREATE INDEX results_shark_throughput_rank_idx ON results_shark (throughput_rank);
