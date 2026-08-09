-- Ranked nightly result rows for BaseKing.
CREATE TABLE results_baseking (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_baseking_summary_idx ON results_baseking (run_summary_id);

CREATE INDEX results_baseking_run_summary_id_idx ON results_baseking (run_summary_id);

CREATE INDEX results_baseking_throughput_rank_idx ON results_baseking (throughput_rank);
