-- Free-text investigation notes for ChaCha20 regressions.
CREATE TABLE regression_notes_chacha20 (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_chacha20_regression_idx ON regression_notes_chacha20 (regression_id);

CREATE INDEX regression_notes_chacha20_regression_id_idx ON regression_notes_chacha20 (regression_id);

CREATE INDEX regression_notes_chacha20_author_idx ON regression_notes_chacha20 (author);
