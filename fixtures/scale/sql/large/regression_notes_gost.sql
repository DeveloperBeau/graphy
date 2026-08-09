-- Free-text investigation notes for GOST regressions.
CREATE TABLE regression_notes_gost (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_gost_regression_idx ON regression_notes_gost (regression_id);

CREATE INDEX regression_notes_gost_regression_id_idx ON regression_notes_gost (regression_id);

CREATE INDEX regression_notes_gost_author_idx ON regression_notes_gost (author);
