-- Ranked nightly result rows for XXTEA.
CREATE TABLE results_xxtea (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_xxtea_summary_idx ON results_xxtea (run_summary_id);

CREATE INDEX results_xxtea_run_summary_id_idx ON results_xxtea (run_summary_id);

CREATE INDEX results_xxtea_throughput_rank_idx ON results_xxtea (throughput_rank);
