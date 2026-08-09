-- Free-text investigation notes for Simeck regressions.
CREATE TABLE regression_notes_simeck (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_simeck_regression_idx ON regression_notes_simeck (regression_id);

CREATE INDEX regression_notes_simeck_regression_id_idx ON regression_notes_simeck (regression_id);

CREATE INDEX regression_notes_simeck_author_idx ON regression_notes_simeck (author);
