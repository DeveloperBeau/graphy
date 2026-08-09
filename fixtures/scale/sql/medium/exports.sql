-- CSV export requests made from the history panel.
CREATE TABLE exports (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users (id),
    requested_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    row_count INTEGER NOT NULL DEFAULT 0,
    format TEXT NOT NULL DEFAULT 'csv'
);

CREATE INDEX exports_user_id_idx ON exports (user_id);

CREATE INDEX exports_requested_at_idx ON exports (requested_at);

CREATE INDEX exports_row_count_idx ON exports (row_count);
