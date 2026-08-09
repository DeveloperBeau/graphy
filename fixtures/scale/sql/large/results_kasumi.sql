-- Ranked nightly result rows for KASUMI.
CREATE TABLE results_kasumi (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_kasumi_summary_idx ON results_kasumi (run_summary_id);

CREATE INDEX results_kasumi_run_summary_id_idx ON results_kasumi (run_summary_id);

CREATE INDEX results_kasumi_throughput_rank_idx ON results_kasumi (throughput_rank);
