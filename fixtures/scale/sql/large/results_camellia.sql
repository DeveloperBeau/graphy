-- Ranked nightly result rows for Camellia.
CREATE TABLE results_camellia (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_camellia_summary_idx ON results_camellia (run_summary_id);

CREATE INDEX results_camellia_run_summary_id_idx ON results_camellia (run_summary_id);

CREATE INDEX results_camellia_throughput_rank_idx ON results_camellia (throughput_rank);
