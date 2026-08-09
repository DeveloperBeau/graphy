-- Ranked nightly result rows for Square.
CREATE TABLE results_square (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_square_summary_idx ON results_square (run_summary_id);

CREATE INDEX results_square_run_summary_id_idx ON results_square (run_summary_id);

CREATE INDEX results_square_throughput_rank_idx ON results_square (throughput_rank);
