-- Free-text investigation notes for MARS regressions.
CREATE TABLE regression_notes_mars (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_mars_regression_idx ON regression_notes_mars (regression_id);

CREATE INDEX regression_notes_mars_regression_id_idx ON regression_notes_mars (regression_id);

CREATE INDEX regression_notes_mars_author_idx ON regression_notes_mars (author);
