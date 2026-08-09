-- Free-text investigation notes for CAST5 regressions.
CREATE TABLE regression_notes_cast5 (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_cast5_regression_idx ON regression_notes_cast5 (regression_id);

CREATE INDEX regression_notes_cast5_regression_id_idx ON regression_notes_cast5 (regression_id);

CREATE INDEX regression_notes_cast5_author_idx ON regression_notes_cast5 (author);
