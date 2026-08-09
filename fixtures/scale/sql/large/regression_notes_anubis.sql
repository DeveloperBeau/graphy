-- Free-text investigation notes for Anubis regressions.
CREATE TABLE regression_notes_anubis (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_anubis_regression_idx ON regression_notes_anubis (regression_id);

CREATE INDEX regression_notes_anubis_regression_id_idx ON regression_notes_anubis (regression_id);

CREATE INDEX regression_notes_anubis_author_idx ON regression_notes_anubis (author);
