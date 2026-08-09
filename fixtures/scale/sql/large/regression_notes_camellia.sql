-- Free-text investigation notes for Camellia regressions.
CREATE TABLE regression_notes_camellia (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_camellia_regression_idx ON regression_notes_camellia (regression_id);

CREATE INDEX regression_notes_camellia_regression_id_idx ON regression_notes_camellia (regression_id);

CREATE INDEX regression_notes_camellia_author_idx ON regression_notes_camellia (author);
