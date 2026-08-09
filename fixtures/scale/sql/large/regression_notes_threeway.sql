-- Free-text investigation notes for 3-Way regressions.
CREATE TABLE regression_notes_threeway (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_threeway_regression_idx ON regression_notes_threeway (regression_id);

CREATE INDEX regression_notes_threeway_regression_id_idx ON regression_notes_threeway (regression_id);

CREATE INDEX regression_notes_threeway_author_idx ON regression_notes_threeway (author);
