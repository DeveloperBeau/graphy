-- Free-text investigation notes for Twofish regressions.
CREATE TABLE regression_notes_twofish (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_twofish_regression_idx ON regression_notes_twofish (regression_id);

CREATE INDEX regression_notes_twofish_regression_id_idx ON regression_notes_twofish (regression_id);

CREATE INDEX regression_notes_twofish_author_idx ON regression_notes_twofish (author);
