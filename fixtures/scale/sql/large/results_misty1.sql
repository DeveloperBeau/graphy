-- Ranked nightly result rows for MISTY1.
CREATE TABLE results_misty1 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_misty1_summary_idx ON results_misty1 (run_summary_id);

CREATE INDEX results_misty1_run_summary_id_idx ON results_misty1 (run_summary_id);

CREATE INDEX results_misty1_throughput_rank_idx ON results_misty1 (throughput_rank);
