-- Free-text investigation notes for FEAL regressions.
CREATE TABLE regression_notes_feal (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_feal_regression_idx ON regression_notes_feal (regression_id);

CREATE INDEX regression_notes_feal_regression_id_idx ON regression_notes_feal (regression_id);

CREATE INDEX regression_notes_feal_author_idx ON regression_notes_feal (author);
