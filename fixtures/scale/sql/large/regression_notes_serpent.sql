-- Free-text investigation notes for Serpent regressions.
CREATE TABLE regression_notes_serpent (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_serpent_regression_idx ON regression_notes_serpent (regression_id);

CREATE INDEX regression_notes_serpent_regression_id_idx ON regression_notes_serpent (regression_id);

CREATE INDEX regression_notes_serpent_author_idx ON regression_notes_serpent (author);
