-- Ranked nightly result rows for GOST.
CREATE TABLE results_gost (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_gost_summary_idx ON results_gost (run_summary_id);

CREATE INDEX results_gost_run_summary_id_idx ON results_gost (run_summary_id);

CREATE INDEX results_gost_throughput_rank_idx ON results_gost (throughput_rank);
