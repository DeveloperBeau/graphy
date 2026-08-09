-- Ranked nightly result rows for MARS.
CREATE TABLE results_mars (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_mars_summary_idx ON results_mars (run_summary_id);

CREATE INDEX results_mars_run_summary_id_idx ON results_mars (run_summary_id);

CREATE INDEX results_mars_throughput_rank_idx ON results_mars (throughput_rank);
