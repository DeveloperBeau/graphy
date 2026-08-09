-- One row per inkroll invocation against a source.
CREATE TABLE jobs (
    id BIGSERIAL PRIMARY KEY,
    queue_id BIGINT NOT NULL REFERENCES queues (id),
    source_id BIGINT NOT NULL REFERENCES sources (id),
    started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    finished_at TIMESTAMPTZ,
    exit_code SMALLINT
);

CREATE INDEX jobs_open_idx ON jobs (finished_at);

CREATE INDEX jobs_queue_id_idx ON jobs (queue_id);

CREATE INDEX jobs_source_id_idx ON jobs (source_id);
