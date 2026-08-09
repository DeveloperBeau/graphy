-- Ranked nightly result rows for Rabbit.
CREATE TABLE results_rabbit (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_rabbit_summary_idx ON results_rabbit (run_summary_id);

CREATE INDEX results_rabbit_run_summary_id_idx ON results_rabbit (run_summary_id);

CREATE INDEX results_rabbit_throughput_rank_idx ON results_rabbit (throughput_rank);
