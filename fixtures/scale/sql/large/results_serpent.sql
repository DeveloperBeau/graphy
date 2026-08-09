-- Ranked nightly result rows for Serpent.
CREATE TABLE results_serpent (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_serpent_summary_idx ON results_serpent (run_summary_id);

CREATE INDEX results_serpent_run_summary_id_idx ON results_serpent (run_summary_id);

CREATE INDEX results_serpent_throughput_rank_idx ON results_serpent (throughput_rank);
