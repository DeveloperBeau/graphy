-- Free-text investigation notes for Skipjack regressions.
CREATE TABLE regression_notes_skipjack (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_skipjack_regression_idx ON regression_notes_skipjack (regression_id);

CREATE INDEX regression_notes_skipjack_regression_id_idx ON regression_notes_skipjack (regression_id);

CREATE INDEX regression_notes_skipjack_author_idx ON regression_notes_skipjack (author);
