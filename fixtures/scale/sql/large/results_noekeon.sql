-- Ranked nightly result rows for NOEKEON.
CREATE TABLE results_noekeon (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_noekeon_summary_idx ON results_noekeon (run_summary_id);

CREATE INDEX results_noekeon_run_summary_id_idx ON results_noekeon (run_summary_id);

CREATE INDEX results_noekeon_throughput_rank_idx ON results_noekeon (throughput_rank);
