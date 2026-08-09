-- Free-text investigation notes for Panama regressions.
CREATE TABLE regression_notes_panama (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_panama_regression_idx ON regression_notes_panama (regression_id);

CREATE INDEX regression_notes_panama_regression_id_idx ON regression_notes_panama (regression_id);

CREATE INDEX regression_notes_panama_author_idx ON regression_notes_panama (author);
