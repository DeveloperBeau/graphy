-- Free-text investigation notes for Sosemanuk regressions.
CREATE TABLE regression_notes_sosemanuk (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_sosemanuk_regression_idx ON regression_notes_sosemanuk (regression_id);

CREATE INDEX regression_notes_sosemanuk_regression_id_idx ON regression_notes_sosemanuk (regression_id);

CREATE INDEX regression_notes_sosemanuk_author_idx ON regression_notes_sosemanuk (author);
