-- Daemon processes tailing a source and feeding jobs.
CREATE TABLE watchers (
    id BIGSERIAL PRIMARY KEY,
    source_id BIGINT NOT NULL REFERENCES sources (id),
    pid INTEGER,
    last_heartbeat TIMESTAMPTZ,
    restarts SMALLINT NOT NULL DEFAULT 0
);

CREATE INDEX watchers_source_id_idx ON watchers (source_id);

CREATE INDEX watchers_pid_idx ON watchers (pid);

CREATE INDEX watchers_last_heartbeat_idx ON watchers (last_heartbeat);
