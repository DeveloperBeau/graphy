-- Ranked nightly result rows for Simon.
CREATE TABLE results_simon (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_simon_summary_idx ON results_simon (run_summary_id);

CREATE INDEX results_simon_run_summary_id_idx ON results_simon (run_summary_id);

CREATE INDEX results_simon_throughput_rank_idx ON results_simon (throughput_rank);
