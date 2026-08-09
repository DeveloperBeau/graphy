-- Ranked nightly result rows for PRINCE.
CREATE TABLE results_prince (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_prince_summary_idx ON results_prince (run_summary_id);

CREATE INDEX results_prince_run_summary_id_idx ON results_prince (run_summary_id);

CREATE INDEX results_prince_throughput_rank_idx ON results_prince (throughput_rank);
