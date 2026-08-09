-- Free-text investigation notes for PRINCE regressions.
CREATE TABLE regression_notes_prince (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_prince_regression_idx ON regression_notes_prince (regression_id);

CREATE INDEX regression_notes_prince_regression_id_idx ON regression_notes_prince (regression_id);

CREATE INDEX regression_notes_prince_author_idx ON regression_notes_prince (author);
