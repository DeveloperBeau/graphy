-- Ranked nightly result rows for Simeck.
CREATE TABLE results_simeck (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_simeck_summary_idx ON results_simeck (run_summary_id);

CREATE INDEX results_simeck_run_summary_id_idx ON results_simeck (run_summary_id);

CREATE INDEX results_simeck_throughput_rank_idx ON results_simeck (throughput_rank);
