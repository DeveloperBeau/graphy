-- Free-text investigation notes for BaseKing regressions.
CREATE TABLE regression_notes_baseking (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_baseking_regression_idx ON regression_notes_baseking (regression_id);

CREATE INDEX regression_notes_baseking_regression_id_idx ON regression_notes_baseking (regression_id);

CREATE INDEX regression_notes_baseking_author_idx ON regression_notes_baseking (author);
