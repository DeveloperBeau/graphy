-- Per-line severity classification for completed jobs.
CREATE TABLE job_lines (
    id BIGSERIAL PRIMARY KEY,
    job_id BIGINT NOT NULL REFERENCES jobs (id),
    line_no INTEGER NOT NULL,
    severity TEXT NOT NULL DEFAULT 'info',
    matched_rule_id BIGINT REFERENCES colour_rules (id)
);

CREATE INDEX job_lines_job_idx ON job_lines (job_id, line_no);

CREATE INDEX job_lines_job_id_idx ON job_lines (job_id);

CREATE INDEX job_lines_line_no_idx ON job_lines (line_no);
