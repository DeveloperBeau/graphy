-- Free-text investigation notes for SAFER regressions.
CREATE TABLE regression_notes_safer (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_safer_regression_idx ON regression_notes_safer (regression_id);

CREATE INDEX regression_notes_safer_regression_id_idx ON regression_notes_safer (regression_id);

CREATE INDEX regression_notes_safer_author_idx ON regression_notes_safer (author);
