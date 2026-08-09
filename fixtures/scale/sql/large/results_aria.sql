-- Ranked nightly result rows for ARIA.
CREATE TABLE results_aria (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_aria_summary_idx ON results_aria (run_summary_id);

CREATE INDEX results_aria_run_summary_id_idx ON results_aria (run_summary_id);

CREATE INDEX results_aria_throughput_rank_idx ON results_aria (throughput_rank);
