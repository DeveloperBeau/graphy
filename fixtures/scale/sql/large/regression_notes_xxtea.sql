-- Free-text investigation notes for XXTEA regressions.
CREATE TABLE regression_notes_xxtea (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_xxtea_regression_idx ON regression_notes_xxtea (regression_id);

CREATE INDEX regression_notes_xxtea_regression_id_idx ON regression_notes_xxtea (regression_id);

CREATE INDEX regression_notes_xxtea_author_idx ON regression_notes_xxtea (author);
