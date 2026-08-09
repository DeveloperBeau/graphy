-- Free-text investigation notes for NOEKEON regressions.
CREATE TABLE regression_notes_noekeon (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_noekeon_regression_idx ON regression_notes_noekeon (regression_id);

CREATE INDEX regression_notes_noekeon_regression_id_idx ON regression_notes_noekeon (regression_id);

CREATE INDEX regression_notes_noekeon_author_idx ON regression_notes_noekeon (author);
