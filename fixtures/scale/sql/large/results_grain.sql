-- Ranked nightly result rows for Grain.
CREATE TABLE results_grain (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_grain_summary_idx ON results_grain (run_summary_id);

CREATE INDEX results_grain_run_summary_id_idx ON results_grain (run_summary_id);

CREATE INDEX results_grain_throughput_rank_idx ON results_grain (throughput_rank);
