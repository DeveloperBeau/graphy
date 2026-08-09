-- Free-text investigation notes for SHARK regressions.
CREATE TABLE regression_notes_shark (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_shark_regression_idx ON regression_notes_shark (regression_id);

CREATE INDEX regression_notes_shark_regression_id_idx ON regression_notes_shark (regression_id);

CREATE INDEX regression_notes_shark_author_idx ON regression_notes_shark (author);
