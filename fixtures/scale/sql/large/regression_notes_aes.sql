-- Free-text investigation notes for AES regressions.
CREATE TABLE regression_notes_aes (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_aes_regression_idx ON regression_notes_aes (regression_id);

CREATE INDEX regression_notes_aes_regression_id_idx ON regression_notes_aes (regression_id);

CREATE INDEX regression_notes_aes_author_idx ON regression_notes_aes (author);
