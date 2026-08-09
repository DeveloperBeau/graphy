-- Free-text investigation notes for Lucifer regressions.
CREATE TABLE regression_notes_lucifer (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_lucifer_regression_idx ON regression_notes_lucifer (regression_id);

CREATE INDEX regression_notes_lucifer_regression_id_idx ON regression_notes_lucifer (regression_id);

CREATE INDEX regression_notes_lucifer_author_idx ON regression_notes_lucifer (author);
