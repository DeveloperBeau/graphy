-- One row per open calculator session.
CREATE TABLE sessions (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users (id),
    started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    ended_at TIMESTAMPTZ,
    device TEXT NOT NULL DEFAULT 'browser'
);

CREATE INDEX sessions_user_id_idx ON sessions (user_id);

CREATE INDEX sessions_started_at_idx ON sessions (started_at);

CREATE INDEX sessions_ended_at_idx ON sessions (ended_at);
