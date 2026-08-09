-- Free-text investigation notes for HC-128 regressions.
CREATE TABLE regression_notes_hc128 (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_hc128_regression_idx ON regression_notes_hc128 (regression_id);

CREATE INDEX regression_notes_hc128_regression_id_idx ON regression_notes_hc128 (regression_id);

CREATE INDEX regression_notes_hc128_author_idx ON regression_notes_hc128 (author);
