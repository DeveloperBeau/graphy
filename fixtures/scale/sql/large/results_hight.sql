-- Ranked nightly result rows for HIGHT.
CREATE TABLE results_hight (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_hight_summary_idx ON results_hight (run_summary_id);

CREATE INDEX results_hight_run_summary_id_idx ON results_hight (run_summary_id);

CREATE INDEX results_hight_throughput_rank_idx ON results_hight (throughput_rank);
