-- Free-form labels attachable to runs.
CREATE TABLE tags (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX tags_name_idx ON tags (name);

CREATE INDEX tags_description_idx ON tags (description);

CREATE INDEX tags_created_at_idx ON tags (created_at);
