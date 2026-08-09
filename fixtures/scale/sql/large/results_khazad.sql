-- Ranked nightly result rows for KHAZAD.
CREATE TABLE results_khazad (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_khazad_summary_idx ON results_khazad (run_summary_id);

CREATE INDEX results_khazad_run_summary_id_idx ON results_khazad (run_summary_id);

CREATE INDEX results_khazad_throughput_rank_idx ON results_khazad (throughput_rank);
