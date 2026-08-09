-- Ranked nightly result rows for IDEA.
CREATE TABLE results_idea (
    id BIGSERIAL PRIMARY KEY,
    run_summary_id BIGINT NOT NULL REFERENCES run_summaries (id),
    throughput_rank SMALLINT,
    latency_rank SMALLINT,
    notes TEXT
);

CREATE INDEX results_idea_summary_idx ON results_idea (run_summary_id);

CREATE INDEX results_idea_run_summary_id_idx ON results_idea (run_summary_id);

CREATE INDEX results_idea_throughput_rank_idx ON results_idea (throughput_rank);
