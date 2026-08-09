-- Ranked nightly result rows for XTEA.
CREATE TABLE results_xtea (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_xtea_summary_idx ON results_xtea (run_summary_id);

CREATE INDEX results_xtea_run_summary_id_idx ON results_xtea (run_summary_id);

CREATE INDEX results_xtea_throughput_rank_idx ON results_xtea (throughput_rank);
