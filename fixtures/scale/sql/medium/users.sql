-- Browser-synced abacus accounts.
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    handle TEXT NOT NULL UNIQUE,
    email TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX users_handle_idx ON users (handle);

CREATE INDEX users_handle_idx ON users (handle);

CREATE INDEX users_email_idx ON users (email);
