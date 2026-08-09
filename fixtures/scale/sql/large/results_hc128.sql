-- Ranked nightly result rows for HC-128.
CREATE TABLE results_hc128 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_hc128_summary_idx ON results_hc128 (run_summary_id);

CREATE INDEX results_hc128_run_summary_id_idx ON results_hc128 (run_summary_id);

CREATE INDEX results_hc128_throughput_rank_idx ON results_hc128 (throughput_rank);
