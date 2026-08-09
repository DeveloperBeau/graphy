-- Free-text investigation notes for Square regressions.
CREATE TABLE regression_notes_square (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_square_regression_idx ON regression_notes_square (regression_id);

CREATE INDEX regression_notes_square_regression_id_idx ON regression_notes_square (regression_id);

CREATE INDEX regression_notes_square_author_idx ON regression_notes_square (author);
