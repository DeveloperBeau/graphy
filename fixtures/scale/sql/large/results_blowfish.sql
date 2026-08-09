-- Ranked nightly result rows for Blowfish.
CREATE TABLE results_blowfish (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_blowfish_summary_idx ON results_blowfish (run_summary_id);

CREATE INDEX results_blowfish_run_summary_id_idx ON results_blowfish (run_summary_id);

CREATE INDEX results_blowfish_throughput_rank_idx ON results_blowfish (throughput_rank);
