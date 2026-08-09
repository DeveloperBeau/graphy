-- Ranked nightly result rows for RC4.
CREATE TABLE results_rc4 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_rc4_summary_idx ON results_rc4 (run_summary_id);

CREATE INDEX results_rc4_run_summary_id_idx ON results_rc4 (run_summary_id);

CREATE INDEX results_rc4_throughput_rank_idx ON results_rc4 (throughput_rank);
