-- Ranked nightly result rows for Anubis.
CREATE TABLE results_anubis (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_anubis_summary_idx ON results_anubis (run_summary_id);

CREATE INDEX results_anubis_run_summary_id_idx ON results_anubis (run_summary_id);

CREATE INDEX results_anubis_throughput_rank_idx ON results_anubis (throughput_rank);
