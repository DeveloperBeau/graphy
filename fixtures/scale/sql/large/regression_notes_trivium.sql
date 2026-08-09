-- Free-text investigation notes for Trivium regressions.
CREATE TABLE regression_notes_trivium (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_trivium_regression_idx ON regression_notes_trivium (regression_id);

CREATE INDEX regression_notes_trivium_regression_id_idx ON regression_notes_trivium (regression_id);

CREATE INDEX regression_notes_trivium_author_idx ON regression_notes_trivium (author);
