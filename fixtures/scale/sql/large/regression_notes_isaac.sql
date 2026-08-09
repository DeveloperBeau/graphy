-- Free-text investigation notes for ISAAC regressions.
CREATE TABLE regression_notes_isaac (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_isaac_regression_idx ON regression_notes_isaac (regression_id);

CREATE INDEX regression_notes_isaac_regression_id_idx ON regression_notes_isaac (regression_id);

CREATE INDEX regression_notes_isaac_author_idx ON regression_notes_isaac (author);
