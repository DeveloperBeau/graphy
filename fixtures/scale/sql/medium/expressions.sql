-- Raw expressions as typed, before evaluation.
CREATE TABLE expressions (
    id BIGSERIAL PRIMARY KEY,
    session_id BIGINT NOT NULL REFERENCES sessions (id),
    raw_text TEXT NOT NULL,
    evaluated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX expressions_session_id_idx ON expressions (session_id);

CREATE INDEX expressions_raw_text_idx ON expressions (raw_text);

CREATE INDEX expressions_evaluated_at_idx ON expressions (evaluated_at);
