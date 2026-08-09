-- Free-text investigation notes for HIGHT regressions.
CREATE TABLE regression_notes_hight (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_hight_regression_idx ON regression_notes_hight (regression_id);

CREATE INDEX regression_notes_hight_regression_id_idx ON regression_notes_hight (regression_id);

CREATE INDEX regression_notes_hight_author_idx ON regression_notes_hight (author);
