-- Ranked nightly result rows for XChaCha20.
CREATE TABLE results_xchacha20 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_xchacha20_summary_idx ON results_xchacha20 (run_summary_id);

CREATE INDEX results_xchacha20_run_summary_id_idx ON results_xchacha20 (run_summary_id);

CREATE INDEX results_xchacha20_throughput_rank_idx ON results_xchacha20 (throughput_rank);
