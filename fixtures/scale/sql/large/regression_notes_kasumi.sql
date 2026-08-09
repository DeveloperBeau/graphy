-- Free-text investigation notes for KASUMI regressions.
CREATE TABLE regression_notes_kasumi (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_kasumi_regression_idx ON regression_notes_kasumi (regression_id);

CREATE INDEX regression_notes_kasumi_regression_id_idx ON regression_notes_kasumi (regression_id);

CREATE INDEX regression_notes_kasumi_author_idx ON regression_notes_kasumi (author);
