-- Ranked nightly result rows for RC2.
CREATE TABLE results_rc2 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_rc2_summary_idx ON results_rc2 (run_summary_id);

CREATE INDEX results_rc2_run_summary_id_idx ON results_rc2 (run_summary_id);

CREATE INDEX results_rc2_throughput_rank_idx ON results_rc2 (throughput_rank);
