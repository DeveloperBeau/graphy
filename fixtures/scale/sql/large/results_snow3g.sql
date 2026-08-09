-- Ranked nightly result rows for SNOW 3G.
CREATE TABLE results_snow3g (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_snow3g_summary_idx ON results_snow3g (run_summary_id);

CREATE INDEX results_snow3g_run_summary_id_idx ON results_snow3g (run_summary_id);

CREATE INDEX results_snow3g_throughput_rank_idx ON results_snow3g (throughput_rank);
