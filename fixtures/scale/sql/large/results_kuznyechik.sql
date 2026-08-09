-- Ranked nightly result rows for Kuznyechik.
CREATE TABLE results_kuznyechik (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_kuznyechik_summary_idx ON results_kuznyechik (run_summary_id);

CREATE INDEX results_kuznyechik_run_summary_id_idx ON results_kuznyechik (run_summary_id);

CREATE INDEX results_kuznyechik_throughput_rank_idx ON results_kuznyechik (throughput_rank);
