-- Ranked nightly result rows for Panama.
CREATE TABLE results_panama (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_panama_summary_idx ON results_panama (run_summary_id);

CREATE INDEX results_panama_run_summary_id_idx ON results_panama (run_summary_id);

CREATE INDEX results_panama_throughput_rank_idx ON results_panama (throughput_rank);
