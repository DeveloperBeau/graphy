-- The small crew reviewing nightly results.
CREATE TABLE maintainers (
    id BIGSERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    handle TEXT NOT NULL UNIQUE
);

CREATE INDEX maintainers_full_name_idx ON maintainers (full_name);

CREATE INDEX maintainers_handle_idx ON maintainers (handle);
