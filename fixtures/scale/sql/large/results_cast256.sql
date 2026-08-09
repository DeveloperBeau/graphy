-- Ranked nightly result rows for CAST-256.
CREATE TABLE results_cast256 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_cast256_summary_idx ON results_cast256 (run_summary_id);

CREATE INDEX results_cast256_run_summary_id_idx ON results_cast256 (run_summary_id);

CREATE INDEX results_cast256_throughput_rank_idx ON results_cast256 (throughput_rank);
