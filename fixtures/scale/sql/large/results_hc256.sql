-- Ranked nightly result rows for HC-256.
CREATE TABLE results_hc256 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_hc256_summary_idx ON results_hc256 (run_summary_id);

CREATE INDEX results_hc256_run_summary_id_idx ON results_hc256 (run_summary_id);

CREATE INDEX results_hc256_throughput_rank_idx ON results_hc256 (throughput_rank);
