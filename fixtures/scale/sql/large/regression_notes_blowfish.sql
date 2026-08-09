-- Free-text investigation notes for Blowfish regressions.
CREATE TABLE regression_notes_blowfish (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_blowfish_regression_idx ON regression_notes_blowfish (regression_id);

CREATE INDEX regression_notes_blowfish_regression_id_idx ON regression_notes_blowfish (regression_id);

CREATE INDEX regression_notes_blowfish_author_idx ON regression_notes_blowfish (author);
