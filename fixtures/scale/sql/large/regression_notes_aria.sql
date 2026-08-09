-- Free-text investigation notes for ARIA regressions.
CREATE TABLE regression_notes_aria (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_aria_regression_idx ON regression_notes_aria (regression_id);

CREATE INDEX regression_notes_aria_regression_id_idx ON regression_notes_aria (regression_id);

CREATE INDEX regression_notes_aria_author_idx ON regression_notes_aria (author);
