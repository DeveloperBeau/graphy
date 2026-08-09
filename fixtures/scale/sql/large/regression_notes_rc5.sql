-- Free-text investigation notes for RC5 regressions.
CREATE TABLE regression_notes_rc5 (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_rc5_regression_idx ON regression_notes_rc5 (regression_id);

CREATE INDEX regression_notes_rc5_regression_id_idx ON regression_notes_rc5 (regression_id);

CREATE INDEX regression_notes_rc5_author_idx ON regression_notes_rc5 (author);
