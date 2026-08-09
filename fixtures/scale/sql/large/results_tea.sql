-- Ranked nightly result rows for TEA.
CREATE TABLE results_tea (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_tea_summary_idx ON results_tea (run_summary_id);

CREATE INDEX results_tea_run_summary_id_idx ON results_tea (run_summary_id);

CREATE INDEX results_tea_throughput_rank_idx ON results_tea (throughput_rank);
