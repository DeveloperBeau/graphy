-- Ranked nightly result rows for ISAAC.
CREATE TABLE results_isaac (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_isaac_summary_idx ON results_isaac (run_summary_id);

CREATE INDEX results_isaac_run_summary_id_idx ON results_isaac (run_summary_id);

CREATE INDEX results_isaac_throughput_rank_idx ON results_isaac (throughput_rank);
