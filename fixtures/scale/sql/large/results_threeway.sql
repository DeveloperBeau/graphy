-- Ranked nightly result rows for 3-Way.
CREATE TABLE results_threeway (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_threeway_summary_idx ON results_threeway (run_summary_id);

CREATE INDEX results_threeway_run_summary_id_idx ON results_threeway (run_summary_id);

CREATE INDEX results_threeway_throughput_rank_idx ON results_threeway (throughput_rank);
