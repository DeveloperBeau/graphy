-- Ranked nightly result rows for LEA.
CREATE TABLE results_lea (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_lea_summary_idx ON results_lea (run_summary_id);

CREATE INDEX results_lea_run_summary_id_idx ON results_lea (run_summary_id);

CREATE INDEX results_lea_throughput_rank_idx ON results_lea (throughput_rank);
