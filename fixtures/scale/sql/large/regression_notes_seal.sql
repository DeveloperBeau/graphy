-- Free-text investigation notes for SEAL regressions.
CREATE TABLE regression_notes_seal (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_seal_regression_idx ON regression_notes_seal (regression_id);

CREATE INDEX regression_notes_seal_regression_id_idx ON regression_notes_seal (regression_id);

CREATE INDEX regression_notes_seal_author_idx ON regression_notes_seal (author);
