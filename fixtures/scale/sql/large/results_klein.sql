-- Ranked nightly result rows for KLEIN.
CREATE TABLE results_klein (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_klein_summary_idx ON results_klein (run_summary_id);

CREATE INDEX results_klein_run_summary_id_idx ON results_klein (run_summary_id);

CREATE INDEX results_klein_throughput_rank_idx ON results_klein (throughput_rank);
