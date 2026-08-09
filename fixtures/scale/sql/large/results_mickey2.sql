-- Ranked nightly result rows for MICKEY.
CREATE TABLE results_mickey2 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_mickey2_summary_idx ON results_mickey2 (run_summary_id);

CREATE INDEX results_mickey2_run_summary_id_idx ON results_mickey2 (run_summary_id);

CREATE INDEX results_mickey2_throughput_rank_idx ON results_mickey2 (throughput_rank);
