-- Ranked nightly result rows for Twofish.
CREATE TABLE results_twofish (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_twofish_summary_idx ON results_twofish (run_summary_id);

CREATE INDEX results_twofish_run_summary_id_idx ON results_twofish (run_summary_id);

CREATE INDEX results_twofish_throughput_rank_idx ON results_twofish (throughput_rank);
