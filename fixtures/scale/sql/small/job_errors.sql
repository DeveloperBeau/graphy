-- Failure detail for jobs that exited non-zero.
CREATE TABLE job_errors (
    id BIGSERIAL PRIMARY KEY,
    job_id BIGINT NOT NULL REFERENCES jobs (id),
    occurred_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    message TEXT NOT NULL,
    exit_code SMALLINT NOT NULL
);

CREATE INDEX job_errors_job_id_idx ON job_errors (job_id);

CREATE INDEX job_errors_occurred_at_idx ON job_errors (occurred_at);

CREATE INDEX job_errors_message_idx ON job_errors (message);
