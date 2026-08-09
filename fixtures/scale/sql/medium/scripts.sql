-- Saved startup scripts defining custom functions.
CREATE TABLE scripts (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users (id),
    name TEXT NOT NULL,
    body TEXT NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX scripts_user_id_idx ON scripts (user_id);

CREATE INDEX scripts_name_idx ON scripts (name);

CREATE INDEX scripts_body_idx ON scripts (body);
