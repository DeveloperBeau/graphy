-- Free-text investigation notes for Speck regressions.
CREATE TABLE regression_notes_speck (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_speck_regression_idx ON regression_notes_speck (regression_id);

CREATE INDEX regression_notes_speck_regression_id_idx ON regression_notes_speck (regression_id);

CREATE INDEX regression_notes_speck_author_idx ON regression_notes_speck (author);
