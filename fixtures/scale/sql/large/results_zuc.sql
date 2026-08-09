-- Ranked nightly result rows for ZUC.
CREATE TABLE results_zuc (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_zuc_summary_idx ON results_zuc (run_summary_id);

CREATE INDEX results_zuc_run_summary_id_idx ON results_zuc (run_summary_id);

CREATE INDEX results_zuc_throughput_rank_idx ON results_zuc (throughput_rank);
