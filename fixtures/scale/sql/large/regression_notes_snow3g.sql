-- Free-text investigation notes for SNOW 3G regressions.
CREATE TABLE regression_notes_snow3g (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_snow3g_regression_idx ON regression_notes_snow3g (regression_id);

CREATE INDEX regression_notes_snow3g_regression_id_idx ON regression_notes_snow3g (regression_id);

CREATE INDEX regression_notes_snow3g_author_idx ON regression_notes_snow3g (author);
