-- Free-text investigation notes for MISTY1 regressions.
CREATE TABLE regression_notes_misty1 (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_misty1_regression_idx ON regression_notes_misty1 (regression_id);

CREATE INDEX regression_notes_misty1_regression_id_idx ON regression_notes_misty1 (regression_id);

CREATE INDEX regression_notes_misty1_author_idx ON regression_notes_misty1 (author);
