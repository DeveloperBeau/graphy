-- Ranked nightly result rows for SAFER.
CREATE TABLE results_safer (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_safer_summary_idx ON results_safer (run_summary_id);

CREATE INDEX results_safer_run_summary_id_idx ON results_safer (run_summary_id);

CREATE INDEX results_safer_throughput_rank_idx ON results_safer (throughput_rank);
