-- Ranked nightly result rows for ChaCha20.
CREATE TABLE results_chacha20 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_chacha20_summary_idx ON results_chacha20 (run_summary_id);

CREATE INDEX results_chacha20_run_summary_id_idx ON results_chacha20 (run_summary_id);

CREATE INDEX results_chacha20_throughput_rank_idx ON results_chacha20 (throughput_rank);
