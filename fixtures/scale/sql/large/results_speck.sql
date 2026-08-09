-- Ranked nightly result rows for Speck.
CREATE TABLE results_speck (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_speck_summary_idx ON results_speck (run_summary_id);

CREATE INDEX results_speck_run_summary_id_idx ON results_speck (run_summary_id);

CREATE INDEX results_speck_throughput_rank_idx ON results_speck (throughput_rank);
