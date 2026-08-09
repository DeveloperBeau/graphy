-- Ranked nightly result rows for Threefish.
CREATE TABLE results_threefish (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_threefish_summary_idx ON results_threefish (run_summary_id);

CREATE INDEX results_threefish_run_summary_id_idx ON results_threefish (run_summary_id);

CREATE INDEX results_threefish_throughput_rank_idx ON results_threefish (throughput_rank);
