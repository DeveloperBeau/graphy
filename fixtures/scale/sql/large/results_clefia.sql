-- Ranked nightly result rows for CLEFIA.
CREATE TABLE results_clefia (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_clefia_summary_idx ON results_clefia (run_summary_id);

CREATE INDEX results_clefia_run_summary_id_idx ON results_clefia (run_summary_id);

CREATE INDEX results_clefia_throughput_rank_idx ON results_clefia (throughput_rank);
