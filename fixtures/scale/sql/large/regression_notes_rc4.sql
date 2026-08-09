-- Free-text investigation notes for RC4 regressions.
CREATE TABLE regression_notes_rc4 (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_rc4_regression_idx ON regression_notes_rc4 (regression_id);

CREATE INDEX regression_notes_rc4_regression_id_idx ON regression_notes_rc4 (regression_id);

CREATE INDEX regression_notes_rc4_author_idx ON regression_notes_rc4 (author);
