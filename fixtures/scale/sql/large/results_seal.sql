-- Ranked nightly result rows for SEAL.
CREATE TABLE results_seal (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_seal_summary_idx ON results_seal (run_summary_id);

CREATE INDEX results_seal_run_summary_id_idx ON results_seal (run_summary_id);

CREATE INDEX results_seal_throughput_rank_idx ON results_seal (throughput_rank);
