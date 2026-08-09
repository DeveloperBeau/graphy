-- Ranked nightly result rows for RC6.
CREATE TABLE results_rc6 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_rc6_summary_idx ON results_rc6 (run_summary_id);

CREATE INDEX results_rc6_run_summary_id_idx ON results_rc6 (run_summary_id);

CREATE INDEX results_rc6_throughput_rank_idx ON results_rc6 (throughput_rank);
