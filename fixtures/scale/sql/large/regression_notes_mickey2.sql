-- Free-text investigation notes for MICKEY regressions.
CREATE TABLE regression_notes_mickey2 (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_mickey2_regression_idx ON regression_notes_mickey2 (regression_id);

CREATE INDEX regression_notes_mickey2_regression_id_idx ON regression_notes_mickey2 (regression_id);

CREATE INDEX regression_notes_mickey2_author_idx ON regression_notes_mickey2 (author);
