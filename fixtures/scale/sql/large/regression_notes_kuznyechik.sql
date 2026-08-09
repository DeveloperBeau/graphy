-- Free-text investigation notes for Kuznyechik regressions.
CREATE TABLE regression_notes_kuznyechik (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_kuznyechik_regression_idx ON regression_notes_kuznyechik (regression_id);

CREATE INDEX regression_notes_kuznyechik_regression_id_idx ON regression_notes_kuznyechik (regression_id);

CREATE INDEX regression_notes_kuznyechik_author_idx ON regression_notes_kuznyechik (author);
