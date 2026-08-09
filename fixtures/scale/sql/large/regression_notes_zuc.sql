-- Free-text investigation notes for ZUC regressions.
CREATE TABLE regression_notes_zuc (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_zuc_regression_idx ON regression_notes_zuc (regression_id);

CREATE INDEX regression_notes_zuc_regression_id_idx ON regression_notes_zuc (regression_id);

CREATE INDEX regression_notes_zuc_author_idx ON regression_notes_zuc (author);
