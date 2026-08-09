-- Ranked nightly result rows for Trivium.
CREATE TABLE results_trivium (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_trivium_summary_idx ON results_trivium (run_summary_id);

CREATE INDEX results_trivium_run_summary_id_idx ON results_trivium (run_summary_id);

CREATE INDEX results_trivium_throughput_rank_idx ON results_trivium (throughput_rank);
