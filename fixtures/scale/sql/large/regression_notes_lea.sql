-- Free-text investigation notes for LEA regressions.
CREATE TABLE regression_notes_lea (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_lea_regression_idx ON regression_notes_lea (regression_id);

CREATE INDEX regression_notes_lea_regression_id_idx ON regression_notes_lea (regression_id);

CREATE INDEX regression_notes_lea_author_idx ON regression_notes_lea (author);
