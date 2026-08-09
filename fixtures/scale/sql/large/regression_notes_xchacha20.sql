-- Free-text investigation notes for XChaCha20 regressions.
CREATE TABLE regression_notes_xchacha20 (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_xchacha20_regression_idx ON regression_notes_xchacha20 (regression_id);

CREATE INDEX regression_notes_xchacha20_regression_id_idx ON regression_notes_xchacha20 (regression_id);

CREATE INDEX regression_notes_xchacha20_author_idx ON regression_notes_xchacha20 (author);
