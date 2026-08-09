-- Free-text investigation notes for TEA regressions.
CREATE TABLE regression_notes_tea (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_tea_regression_idx ON regression_notes_tea (regression_id);

CREATE INDEX regression_notes_tea_regression_id_idx ON regression_notes_tea (regression_id);

CREATE INDEX regression_notes_tea_author_idx ON regression_notes_tea (author);
