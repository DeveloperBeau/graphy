-- Input streams feeding a queue: files, fifos or command pipes.
CREATE TABLE sources (
    id BIGSERIAL PRIMARY KEY,
    queue_id BIGINT NOT NULL REFERENCES queues (id),
    path TEXT NOT NULL,
    kind TEXT NOT NULL DEFAULT 'file',
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE INDEX sources_queue_id_idx ON sources (queue_id);

CREATE INDEX sources_path_idx ON sources (path);

CREATE INDEX sources_kind_idx ON sources (kind);
