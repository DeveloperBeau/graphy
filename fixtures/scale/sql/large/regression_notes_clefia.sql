-- Free-text investigation notes for CLEFIA regressions.
CREATE TABLE regression_notes_clefia (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_clefia_regression_idx ON regression_notes_clefia (regression_id);

CREATE INDEX regression_notes_clefia_regression_id_idx ON regression_notes_clefia (regression_id);

CREATE INDEX regression_notes_clefia_author_idx ON regression_notes_clefia (author);
