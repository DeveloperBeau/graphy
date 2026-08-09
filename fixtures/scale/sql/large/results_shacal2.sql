-- Ranked nightly result rows for SHACAL-2.
CREATE TABLE results_shacal2 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_shacal2_summary_idx ON results_shacal2 (run_summary_id);

CREATE INDEX results_shacal2_run_summary_id_idx ON results_shacal2 (run_summary_id);

CREATE INDEX results_shacal2_throughput_rank_idx ON results_shacal2 (throughput_rank);
