-- Free-text investigation notes for XTEA regressions.
CREATE TABLE regression_notes_xtea (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_xtea_regression_idx ON regression_notes_xtea (regression_id);

CREATE INDEX regression_notes_xtea_regression_id_idx ON regression_notes_xtea (regression_id);

CREATE INDEX regression_notes_xtea_author_idx ON regression_notes_xtea (author);
