-- Free-text investigation notes for SEED regressions.
CREATE TABLE regression_notes_seed (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_seed_regression_idx ON regression_notes_seed (regression_id);

CREATE INDEX regression_notes_seed_regression_id_idx ON regression_notes_seed (regression_id);

CREATE INDEX regression_notes_seed_author_idx ON regression_notes_seed (author);
