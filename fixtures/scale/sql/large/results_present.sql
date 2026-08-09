-- Ranked nightly result rows for PRESENT.
CREATE TABLE results_present (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_present_summary_idx ON results_present (run_summary_id);

CREATE INDEX results_present_run_summary_id_idx ON results_present (run_summary_id);

CREATE INDEX results_present_throughput_rank_idx ON results_present (throughput_rank);
