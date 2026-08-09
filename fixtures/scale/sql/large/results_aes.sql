-- Ranked nightly result rows for AES.
CREATE TABLE results_aes (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_aes_summary_idx ON results_aes (run_summary_id);

CREATE INDEX results_aes_run_summary_id_idx ON results_aes (run_summary_id);

CREATE INDEX results_aes_throughput_rank_idx ON results_aes (throughput_rank);
