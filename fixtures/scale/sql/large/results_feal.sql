-- Ranked nightly result rows for FEAL.
CREATE TABLE results_feal (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_feal_summary_idx ON results_feal (run_summary_id);

CREATE INDEX results_feal_run_summary_id_idx ON results_feal (run_summary_id);

CREATE INDEX results_feal_throughput_rank_idx ON results_feal (throughput_rank);
