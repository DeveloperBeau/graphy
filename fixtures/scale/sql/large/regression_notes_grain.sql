-- Free-text investigation notes for Grain regressions.
CREATE TABLE regression_notes_grain (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_grain_regression_idx ON regression_notes_grain (regression_id);

CREATE INDEX regression_notes_grain_regression_id_idx ON regression_notes_grain (regression_id);

CREATE INDEX regression_notes_grain_author_idx ON regression_notes_grain (author);
