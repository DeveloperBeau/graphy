-- Ranked nightly result rows for Lucifer.
CREATE TABLE results_lucifer (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_lucifer_summary_idx ON results_lucifer (run_summary_id);

CREATE INDEX results_lucifer_run_summary_id_idx ON results_lucifer (run_summary_id);

CREATE INDEX results_lucifer_throughput_rank_idx ON results_lucifer (throughput_rank);
