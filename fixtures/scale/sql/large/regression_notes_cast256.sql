-- Free-text investigation notes for CAST-256 regressions.
CREATE TABLE regression_notes_cast256 (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_cast256_regression_idx ON regression_notes_cast256 (regression_id);

CREATE INDEX regression_notes_cast256_regression_id_idx ON regression_notes_cast256 (regression_id);

CREATE INDEX regression_notes_cast256_author_idx ON regression_notes_cast256 (author);
