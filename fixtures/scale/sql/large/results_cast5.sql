-- Ranked nightly result rows for CAST5.
CREATE TABLE results_cast5 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_cast5_summary_idx ON results_cast5 (run_summary_id);

CREATE INDEX results_cast5_run_summary_id_idx ON results_cast5 (run_summary_id);

CREATE INDEX results_cast5_throughput_rank_idx ON results_cast5 (throughput_rank);
