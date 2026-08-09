-- Ranked nightly result rows for Sosemanuk.
CREATE TABLE results_sosemanuk (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_sosemanuk_summary_idx ON results_sosemanuk (run_summary_id);

CREATE INDEX results_sosemanuk_run_summary_id_idx ON results_sosemanuk (run_summary_id);

CREATE INDEX results_sosemanuk_throughput_rank_idx ON results_sosemanuk (throughput_rank);
