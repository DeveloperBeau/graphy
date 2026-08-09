-- Ranked nightly result rows for SEED.
CREATE TABLE results_seed (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_seed_summary_idx ON results_seed (run_summary_id);

CREATE INDEX results_seed_run_summary_id_idx ON results_seed (run_summary_id);

CREATE INDEX results_seed_throughput_rank_idx ON results_seed (throughput_rank);
