-- Free-text investigation notes for KLEIN regressions.
CREATE TABLE regression_notes_klein (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_klein_regression_idx ON regression_notes_klein (regression_id);

CREATE INDEX regression_notes_klein_regression_id_idx ON regression_notes_klein (regression_id);

CREATE INDEX regression_notes_klein_author_idx ON regression_notes_klein (author);
