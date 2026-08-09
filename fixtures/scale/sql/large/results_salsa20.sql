-- Ranked nightly result rows for Salsa20.
CREATE TABLE results_salsa20 (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_salsa20_summary_idx ON results_salsa20 (run_summary_id);

CREATE INDEX results_salsa20_run_summary_id_idx ON results_salsa20 (run_summary_id);

CREATE INDEX results_salsa20_throughput_rank_idx ON results_salsa20 (throughput_rank);
