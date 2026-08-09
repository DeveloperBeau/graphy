-- Free-text investigation notes for Simon regressions.
CREATE TABLE regression_notes_simon (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_simon_regression_idx ON regression_notes_simon (regression_id);

CREATE INDEX regression_notes_simon_regression_id_idx ON regression_notes_simon (regression_id);

CREATE INDEX regression_notes_simon_author_idx ON regression_notes_simon (author);
